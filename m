Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317417AbSFCQrN>; Mon, 3 Jun 2002 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFCQrM>; Mon, 3 Jun 2002 12:47:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317417AbSFCQrL>; Mon, 3 Jun 2002 12:47:11 -0400
Date: Mon, 3 Jun 2002 09:47:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between
 writeback and unlink)
In-Reply-To: <20020603162630.GC7905@turbolinux.com>
Message-ID: <Pine.LNX.4.44.0206030946360.2312-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jun 2002, Andreas Dilger wrote:
>
> If I had one minor note it would be to rename "common_*()" to "generic_*()"
> to match the other VFS helper routines.

Good point. Will do.

		Linus

