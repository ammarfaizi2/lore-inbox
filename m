Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTAKCC3>; Fri, 10 Jan 2003 21:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTAKCC2>; Fri, 10 Jan 2003 21:02:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:53134 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267104AbTAKCC2> convert rfc822-to-8bit;
	Fri, 10 Jan 2003 21:02:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] remove cruel torture of macros and small furry animals in io-apic.c
Date: Fri, 10 Jan 2003 18:11:14 -0800
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <308730000.1042246466@flay>
In-Reply-To: <308730000.1042246466@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101811.14348.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 02:11:07.0556 (UTC) FILETIME=[B3BA8640:01C2B916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri January 10 2003 16:54, Martin J. Bligh wrote:
> Andrew, sent to you because I figure it might appeal to you,
> just based on a random gut feeling.

Once one has spent the effort to decrypt a piece of kernel arcanery it is
always nice, I think, to leave a few illuminating comments behind.  So the
next poor traveller's brain is not also reduced to silly putty.

But ah well.  This is the sort of patch in which breakage will be quickly and
loudly found so thanks, let's put it in for testing.

 

