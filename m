Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVJ2CmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVJ2CmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVJ2CmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:42:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:29319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750722AbVJ2CmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:42:11 -0400
Date: Fri, 28 Oct 2005 19:41:24 -0700
From: Greg KH <greg@kroah.com>
To: Marek Szuba <cyberman@if.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still no USB 2.0 with 2.6.14 (on AMD64+nForce4)
Message-ID: <20051029024123.GA25129@kroah.com>
References: <Pine.LNX.4.62.0510290423010.23723@gyrvynk.vs.cj.rqh.cy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510290423010.23723@gyrvynk.vs.cj.rqh.cy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 04:30:58AM +0200, Marek Szuba wrote:
> Hello,
> 
> Well, the topic says it all: regardless of whichever USB device I plug in, 
> it never shows up as a high-speed one using EHCI even if it damn well 
> should, and does work in high-speed mode when plugged into the same 
> computer while running Win. Unfortunately the workaround I found on 
> kerneltrap by googling, i.e. disabling USB 2.0 in BIOS, doesn't work for 
> me, even though I have tried all possible combination of related options 
> which didn't shut USB down entriely.
> 
> Any chance of having this bug fixed soon? Or maybe, since AFAIK the 
> problem did not exist before 2.6.10, there is a patch which one could use 
> to temporarily restore old behaviour?
> 
> As always, if you need any more information about the system in question 
> or any other technical details, just let me know; I'm on LKML again right 
> now.

Care to send this to linux-usb-devel and file a bug at
bugzilla.kernel.org so we can track it?

thanks,

greg k-h
