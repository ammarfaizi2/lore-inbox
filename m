Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCOSoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCOSoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVCOSk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:40:26 -0500
Received: from port-83-236-181-26.static.qsc.de ([83.236.181.26]:23693 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S261647AbVCOSjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:39:32 -0500
Date: Tue, 15 Mar 2005 19:39:22 +0100
From: Robert Schwebel <robert@schwebel.de>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: CANbus subsytem for 2.6 kernel (char or netdev)
Message-ID: <20050315183922.GP11709@pengutronix.de>
References: <4236B1D1.7030707@varma-el.com> <1110884699.5812.10.camel@atlas.tec.linutronix.de> <4236CC87.5030401@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4236CC87.5030401@varma-el.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:52:39PM +0300, Andrey Volkov wrote:
> Benedikt Spranger wrote:
> >>Anyone could told me, why everyone, who wrote CANbus driver (peak, 
> >>kvaser etc) always use char dev, but not netdev for it? May be exist 
> >>some global pitfall, which I couldn't see, which prevent to use netdev?
> >
> >
> >Maybe you try out:
> >http://www.linutronix.de/data/linux-2.6.11-can.diff

We have a newer version of this patch which we are currently making
ready for upstream. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

