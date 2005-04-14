Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDNXPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDNXPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVDNXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:15:35 -0400
Received: from mail.zmailer.org ([62.78.96.67]:17846 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261645AbVDNXPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:15:17 -0400
Date: Fri, 15 Apr 2005 02:15:13 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: abonilla <abonilla@linuxwireless.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad T42 - Looking for a Developer.
Message-ID: <20050414231513.GN3858@mea-ext.zmailer.org>
References: <003901c54136$6ba545c0$9f0cc60a@amer.sykes.com> <Pine.LNX.4.62.0504142317480.3466@dragon.hyggekrogen.localhost> <20050414223641.M49815@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414223641.M49815@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 06:40:16PM -0400, abonilla wrote:
> On Thu, 14 Apr 2005 23:20:19 +0200 (CEST), Jesper Juhl wrote
> > On Thu, 14 Apr 2005, Alejandro Bonilla wrote:
...
> > >  This is located in my home PC, Won't be the fastest downloads...
> > >  
> > >  http://wifitux.com/finger/
> >  
> > Under what terms did you obtain these documents and from where? Are 
> > they completely freely distributable or are there strings attached?
> 
> I emailed the guys and they told me, "Hey, here you go, let me know if you
> want more information"
> 
> I guess it can't be more distributable. But as far as I got to read. The
> documents don't have too much information like for us to do a great Job. I
> think it also requires the making of a firmware.
> 
> I don't want to dissapoint you, but I hope I'm lost and that a driver can be
> done out of this.

There were two PDF documents.
The more useful one tells that there are two possible interfaces:
 - Async serial
 - USB

Could you show what    /sbin/lsusb -vv    tells in your T42 ?
Do that without external devices attached.
 
> > -- 
> > Jesper

/Matti Aarnio
