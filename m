Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUHTCfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUHTCfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHTCfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:35:24 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:19608 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266006AbUHTCfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:35:16 -0400
Subject: Re: Memory Stick Pro driver
From: "Raf D'Halleweyn" <raf@noduck.net>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092317583.13824.114.camel@rade7.e.cs.auc.dk>
References: <1092312640.13824.89.camel@rade7.e.cs.auc.dk>
	 <yw1xu0v8cyw0.fsf@kth.se>  <1092315367.13824.95.camel@rade7.e.cs.auc.dk>
	 <1092315960.13824.97.camel@rade7.e.cs.auc.dk>
	 <1092317583.13824.114.camel@rade7.e.cs.auc.dk>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Aug 2004 22:35:13 -0400
Message-Id: <1092969313.5230.7.camel@alto.dhalleweyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to upgrade the firmware of the memory stick reader. Sony
provides software to do that, which runs under Windows.

I have done this, and Linux successfully can read pro sticks.

Raf.

On Thu, 2004-08-12 at 15:33 +0200, Emmanuel Fleury wrote:
> Hi again,
> 
> After some small investigation, it seems that:
> 
> « Some products in some categories (PC, PDA) will be able to accept
> Memory Stick PRO media by upgrading firmware or software. (Available
> advantage is high capacity only.) »
> 
> Read at the bottom of this page:
> http://www.memorystick.com/en/ms/features2.html
> 
> Moreover, on this page:
> http://ciscdb.sel.sony.com/perl/news-display.pl?news_id=15
> 
> I can see that Vaio laptop similar to mine (C1MW and C1MWP) can be
> upgraded to read Memory stick Pro...
> 
> So, I guess that it is possible. But why is the Linux driver refusing it
> ?
> 
> I'll try this out.
> 
> PS: Who is the maintainer of the Memory Stick driver ?
> 
> Regards

