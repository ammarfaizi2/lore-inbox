Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSBIKbz>; Sat, 9 Feb 2002 05:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSBIKbn>; Sat, 9 Feb 2002 05:31:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43218 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288830AbSBIKbe>; Sat, 9 Feb 2002 05:31:34 -0500
Date: Sat, 9 Feb 2002 10:33:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C64DE99.D8F2DC61@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202091027420.6135-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Andrew Morton wrote:
> 
> The implementation looks fine to me.  You've checked that it
> builds OK with CONFIG_DEBUG_BUGVERBOSE=n?

I have checked now, and yes, that builds fine: thanks.

Hugh

