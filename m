Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbRB0JHy>; Tue, 27 Feb 2001 04:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRB0JHo>; Tue, 27 Feb 2001 04:07:44 -0500
Received: from fungus.teststation.com ([212.32.186.211]:58805 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129536AbRB0JHb>; Tue, 27 Feb 2001 04:07:31 -0500
Date: Tue, 27 Feb 2001 10:07:07 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH] via-rhine.c: don't reference skb after passing it to
 netif_rx
In-Reply-To: <20010226211536.O8692@conectiva.com.br>
Message-ID: <Pine.LNX.4.30.0102270939290.5264-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Arnaldo Carvalho de Melo wrote:

> thanks, I'll take that into account for the remaining ones and this should
> be checked by the driver authors for the ones I've already sent.

The pkt_len variant is already in 2.4.1-ac15 and probably before that
(changed by Manfred Spraul back in ac4?).

Perhaps you should run through the drivers in -acX instead/also?
(too late now I guess :)

/Urban

