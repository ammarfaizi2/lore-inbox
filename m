Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135897AbREBUtU>; Wed, 2 May 2001 16:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135892AbREBUtK>; Wed, 2 May 2001 16:49:10 -0400
Received: from zmailer.org ([194.252.70.162]:34823 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135782AbREBUsw>;
	Wed, 2 May 2001 16:48:52 -0400
Date: Wed, 2 May 2001 23:48:38 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: nervlord@iinet.net.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPNA
Message-ID: <20010502234838.Z805@mea-ext.zmailer.org>
In-Reply-To: <200104300600.OAA11559@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104300600.OAA11559@localhost.localdomain>; from nervlord@iinet.net.au on Mon, Apr 30, 2001 at 02:00:49PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 02:00:49PM +0800, nervlord@iinet.net.au wrote:
> Hello sorry to interupt ur work, i was a subscriber to the kernel mailing 
> list before and realise how much traffic you get.
> 
> My friend has a DIAMOND homefree network card using HPNA
> i was wondering what hte status of HPNA is in the kernel?
> to refresh HPNA allows you to network ur machines via the phone lines  in 
> america.

	The Home-PNA cards look like ethernet cards to the kernel.
	Does the specification tell something about the PROTOCOLS
	to be run, that I have not checked.

	For example, the Tulip driver (www.scyld.com) understands
	PHY interface called Home-PNA.

	Comparing to the Ethernet (10/100/1000/more Mbit/sec),
	the Home-PNA runs at 1 Mbit/sec.  (And thus can use
	in-house CAT-3 telephony cabling.)

> Kind Regards
> Peter Revilll

/Matti Aarnio
