Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318748AbSHSMZJ>; Mon, 19 Aug 2002 08:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318744AbSHSMZI>; Mon, 19 Aug 2002 08:25:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11767 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318748AbSHSMZI>; Mon, 19 Aug 2002 08:25:08 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marco Colombo <marco@esi.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208191220260.26653-100000@Megathlon.ESI>
References: <Pine.LNX.4.44.0208191220260.26653-100000@Megathlon.ESI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 13:29:10 +0100
Message-Id: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 11:47, Marco Colombo wrote:
> 
> BTW, I know you wrote the amd768-rng driver, I wonder if you have any
> indication of how good these rng are. What is the typical output bits/
> random bits ratio in normal applications?

It seems random. People have subjected both the intel and AMD one to
statistical test sets. I'm not a cryptographer or a statistician so I
can't answer usefully

