Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319756AbSIMTOb>; Fri, 13 Sep 2002 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319757AbSIMTOa>; Fri, 13 Sep 2002 15:14:30 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:34826 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S319756AbSIMTOD>; Fri, 13 Sep 2002 15:14:03 -0400
Date: Fri, 13 Sep 2002 21:18:49 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: =?iso-8859-2?Q?Vladim=EDr_T=F8ebick=FD?= <druid@mail.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALi M1543 on P200
Message-ID: <20020913191849.GU28541@louise.pinerecords.com>
References: <001701c25b59$7756a820$4500a8c0@cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c25b59$7756a820$4500a8c0@cybernet.cz>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 18 days, 23:42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ALI15X3: simplex device with no drives: DMA disabled
> ALI15X3: simplex device with no drives: DMA disabled

DMA is temporarily disabled on simplex devices.

This is work in progress as stated in multiple lkml posts
and also in the recent -ac kernels release notes.

T.
