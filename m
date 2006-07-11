Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGKN26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGKN26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGKN26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:28:58 -0400
Received: from lucidpixels.com ([66.45.37.187]:48821 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750760AbWGKN25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:28:57 -0400
Date: Tue, 11 Jul 2006 09:28:51 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: LibPATA code issues / 2.6.17.3 (What is the next step?)
In-Reply-To: <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0607110926150.858@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>
  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>
  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan> 
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan> 
 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan> 
 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
 <1152545639.27368.137.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan/Jeff/Mark,

Is there anything else I can do to further troubleshoot this problem now 
that we have the failed opcode(s)?  Again, there is never any corruption 
on these drives, so it is more of an annoyance than anything else.

Other people also have this problem with these drives if you search Google 
but I am not sure they are aware of where to report their errors/problems.

opcode=0x35 & opcode=0xca

Justin.
