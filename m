Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVDBKfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDBKfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 05:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDBKfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 05:35:25 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18948 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261354AbVDBKfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 05:35:18 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-os@analogic.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] clean up kernel messages
Date: Sat, 2 Apr 2005 13:35:07 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20050401200851.GG15453@waste.org> <1112390785.578.5.camel@localhost.localdomain> <Pine.LNX.4.61.0504011703400.30945@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0504011703400.30945@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504021335.07611.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 April 2005 01:08, Richard B. Johnson wrote:
> >> Looking at your other patches, I'm assuming that this is just another
> >> April 1st type of patch. Is it?
> >
> > Arg! I'm too tired.  I took another look at your other patches and they
> > look more legit now. On first glance, I thought you were just bluntly
> > removing BUGs and error messages to quiet things down. But after taking
> > another look, I see that they are more than that.  I wouldn't of thought
> > about that on any other day.
> >
> > Sorry,
> >
> >
> > -- Steve
> 
> Methinks he still is kidding. We have "quiet" as a parameter now
> to quiet things down on a boot. Now if he would just get rid
> of the annoying...
> >>>>>  Loading Linux... Uncompressing kernel...
> He'd have something.

I suppose this is intended for embedded builds for devices with
no means whatsoever to send kernel log anywhere humanly visible.
--
vda

