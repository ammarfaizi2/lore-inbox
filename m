Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbXAIAj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAIAj1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbXAIAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:39:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:34602 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbXAIAj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:39:26 -0500
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45A25C17.5070606@246tNt.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <200701081550.27748.m.kozlowski@tuxland.pl>  <45A25C17.5070606@246tNt.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:38:59 +1100
Message-Id: <1168303139.22458.246.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> Don't build ohci as module for now.
> A fix for that is already in gregkh usb tree for 2.6.21

Do you mean that as-is, powerpc defconfigs cannot build USB as a module
in 2.6.20 ? That is unacceptable as a regression. We need a fix in
2.6.20.

Greg, what is the status there ?

Ben.


