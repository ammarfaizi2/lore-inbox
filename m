Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRJHLo6>; Mon, 8 Oct 2001 07:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJHLot>; Mon, 8 Oct 2001 07:44:49 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:6404 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S272737AbRJHLoj>;
	Mon, 8 Oct 2001 07:44:39 -0400
Date: Mon, 8 Oct 2001 13:45:09 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Klaus Dittrich <kladit@t-online.de>
cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11.p4 and dd
In-Reply-To: <20011007203540.A392@df1tlpc.local.here>
Message-ID: <Pine.LNX.4.33.0110081343280.1775-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Klaus Dittrich wrote:

> 2.4.3 uses a large amount of buffer, 2.4.11p4 only chache.

Block devices are handled by the page cache in 2.4.10 and up.

> 2.4.3 doesn't swap, 2.4.11p4 eats up 1 GB RAM and 100 MB swap.

This is a bug in pre4.  Please try pre5 instead!

/Tobias

