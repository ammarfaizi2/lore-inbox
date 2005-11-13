Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVKMVD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKMVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVKMVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:03:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:61152 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750706AbVKMVD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:03:27 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Buesch <mbuesch@freenet.de>,
       ppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122145.38409.mbuesch@freenet.de>
	 <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	 <200511122237.17157.mbuesch@freenet.de> <1131834336.7406.46.camel@gaston>
	 <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 07:59:20 +1100
Message-Id: <1131915560.5504.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 10:37 -0600, Kumar Gala wrote:

> Can we please add some defconfigs for arch/powerpc to possibly help  
> with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
> bit configs would be a good start.

The 64 bits defconfigs are there already. I'll do a pmac one.

Ben.


