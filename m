Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315225AbSD2WXy>; Mon, 29 Apr 2002 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315224AbSD2WXy>; Mon, 29 Apr 2002 18:23:54 -0400
Received: from www.transvirtual.com ([206.14.214.140]:60939 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315223AbSD2WXw>; Mon, 29 Apr 2002 18:23:52 -0400
Date: Mon, 29 Apr 2002 15:23:44 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.11 + framebuffer compile patch -- OOPS in blk_get_readahead+a/60
In-Reply-To: <1020118099.1918.25.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10204291522510.29647-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>EIP; c01ee59a <blk_get_readahead+a/60>   <=====
> Trace; c023a87c <device_size_calculation+ac/230>
> Trace; c023ab1f <do_md_run+11f/3d0>
> Trace; c02286eb <fbcon_cursor+9b/200>

That is strange. Which framebuffer driver are you using?


