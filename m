Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSFGWXP>; Fri, 7 Jun 2002 18:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSFGWXO>; Fri, 7 Jun 2002 18:23:14 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:59403 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S310206AbSFGWXO>; Fri, 7 Jun 2002 18:23:14 -0400
Message-Id: <200206072220.g57MJx955869@aslan.scsiguy.com>
To: James Bourne <jbourne@mtroyal.ab.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 AIC7XXX hard lockup 
In-Reply-To: Your message of "Fri, 07 Jun 2002 15:29:56 MDT."
             <Pine.LNX.4.44.0206070726060.27407-102000@skuld.mtroyal.ab.ca> 
Date: Fri, 07 Jun 2002 16:19:59 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Now, what is happening is when we are initializing the JBs, the host
>system will abruptly hang.  Turning on aic7xxx=verbose on the kernel
>command line has given additional output, but still nothing solid as far
>as trouble shooting information.

I'd like to see the debugging output anyway.

You might also try 6.2.8 which is in the latest Marcelo tree.

--
Justin
