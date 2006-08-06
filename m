Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWHFWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWHFWnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHFWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:43:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59333 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750750AbWHFWnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:43:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2
Date: Mon, 7 Aug 2006 00:42:10 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070042.10485.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 12:08, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

My box's (Asus L5D, x86_64) keyboard doesn't work on this kernel at all, even
if I boot with init=/bin/bash.  On the 2.6.18-rc2-mm1 it worked.

Unfortunately I have no indication what can be wrong, no oopses, no error
messages in dmesg, nothing.

Right now I'm doing a binary search for the offending patch.

Greetings,
Rafael
