Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316717AbSEWOPg>; Thu, 23 May 2002 10:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316726AbSEWOPf>; Thu, 23 May 2002 10:15:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61959 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316717AbSEWOPe>; Thu, 23 May 2002 10:15:34 -0400
Date: Thu, 23 May 2002 10:11:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip alias and default outgoing interface
In-Reply-To: <Pine.LNX.4.44.0205220003060.3979-100000@viper.haque.net>
Message-ID: <Pine.LNX.3.96.1020523101028.11249B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Mohammad A. Haque wrote:

> I've got a setup where I have one ethernet card and multiple ips 
> assigned using ip alias.
> 
> i've noticed that sometimes out going traffic goes out using the ip of 
> the last interface I brought up.
> 
> Is this supposed to happen? How do I make it so that the default gw 
> interface is used?

Time to tell us which kernel you run. I haven't seen this with 2.4.recent,
but most of the connections are either incoming or explicitly SNET'd.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

