Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319105AbSHSXpX>; Mon, 19 Aug 2002 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSHSXpX>; Mon, 19 Aug 2002 19:45:23 -0400
Received: from watchdog.cdt.org ([206.112.85.61]:56246 "EHLO mail.cdt.org")
	by vger.kernel.org with ESMTP id <S319105AbSHSXpW>;
	Mon, 19 Aug 2002 19:45:22 -0400
Date: Mon, 19 Aug 2002 19:49:21 -0400 (EDT)
From: Daniel Berlin <dberlin@dberlin.org>
Reply-To: dberlin@dberlin.org
To: "David S. Miller" <davem@redhat.com>
Cc: thunder@lightweight.ods.org, <zdzichu@irc.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and full ipv6 - will it happen?
In-Reply-To: <20020819.162340.133733118.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208191948130.4566-100000@dberlin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, David S. Miller wrote:

>    From: Thunder from the hill <thunder@lightweight.ods.org>
>    Date: Mon, 19 Aug 2002 17:34:51 -0600 (MDT)
>    
>    We're using it for years now. Works well, made me incredibly happy ever
>    since. Just too cool thing.
> 
> The keyword is "you", you are using is locally at your site.
> 
> There are zero backbone ipv6 routers, everyone is still tunneling
> or has a custom network layout for their usage.

Errr, not quite:

>From a presentation entitled "Commercial IPV6 at Worldcom"                                                                                                                      
Page 6

   vBNS+ IPv6 Service Overview
   * Native (not tunneled) IPv6-over-ATM
   backbone since July 1998
   * Dedicated hardware (Cisco 4700s and a
   7507 with OC3/ATM) for IPv6 routing.
   * Full mesh of ATM PVCs among the IPv6
   routers.
   * Backbone provider (pTLA) for the global
   6bone.


There are other backbone ipv6 routers, too, that are non-tunneled.

--Dan

