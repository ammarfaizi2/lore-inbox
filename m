Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRHANTg>; Wed, 1 Aug 2001 09:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbRHANT0>; Wed, 1 Aug 2001 09:19:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:28801 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266970AbRHANTM>;
	Wed, 1 Aug 2001 09:19:12 -0400
Date: Wed, 1 Aug 2001 09:59:41 -0300
From: aris@cathedrallabs.org
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org, bao.ha@srs.gov, dupuis@lei.ucl.ac.be
Subject: Re: Problems trying to use a Intel EtherExpress Pro/10
Message-ID: <20010801095941.A371@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010801110948.A762@man.beta.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> I have a couple of Intel NICs based on chip FA82595TX, the NIC model is
> 650092, wich is not listed on Intel's site. Anyway, it is recogniced on both
> 2.2.19 and 2.4.7 as an Intel EtherExpress Pro/10 ISA, I can ifconfig it and
> everything, but when I try to use it, I get either no packets sent, none
> received, or packets sent but also a lot of errors and carrier, anyway, I
> never get to receive a packet.
your board is supported but the driver in kernel is broken at this moment.
i'm working hardly these days to make it really stable and i'll release it
soon. anyway i put you in my list of beta-testers :)

aris
