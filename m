Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263314AbVCEAgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbVCEAgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbVCEAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:06:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:54493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263394AbVCDXDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:03:03 -0500
Date: Fri, 4 Mar 2005 15:02:42 -0800
From: Greg KH <greg@kroah.com>
To: Mickey Stein <yekkim@pacbell.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] I2C: Fix some gcc 4.0 compile failures and warnings
Message-ID: <20050304230242.GA2408@kroah.com>
References: <11099685961021@kroah.com> <4228E74F.9070706@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228E74F.9070706@pacbell.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:55:11PM -0800, Mickey Stein wrote:
> I was just scanning this email and it looks like you possibly grabbed 
> the first of my patches with a typo because this last little bit I 
> corrected in a prior email to you.   It  got into the  *mm* tree  ok.  
> So I'm not sure where this took a wrong turn again.

You missed the follow-on patch that fixed this up :)

thanks,

greg k-h
