Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRAKBNS>; Wed, 10 Jan 2001 20:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAKBNJ>; Wed, 10 Jan 2001 20:13:09 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:65036 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129868AbRAKBM7>; Wed, 10 Jan 2001 20:12:59 -0500
Date: Wed, 10 Jan 2001 21:21:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ulrich Schwarz <uschwarz@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 vm BUG (ksymoopsed)
In-Reply-To: <20010111011328.A2945@fruli.2y.net>
Message-ID: <Pine.LNX.4.21.0101102121141.8803-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Jan 2001, Ulrich Schwarz wrote:

> 2.4.0 (final i586) patched with reiserfs 3.6.25 produced the following BUG:
> 
> 
> the console report (ksymoopsed):
> 
> kernel BUG at vmscan.c:452!
> invalid operand: 0000

Does reiserfs patch changes vmscan.c ?

If so, whats in line 452 of mm/vmscan.c of 2.4.0 reiserfs tree? 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
