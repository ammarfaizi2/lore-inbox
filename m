Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136060AbRAGQwf>; Sun, 7 Jan 2001 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136085AbRAGQwZ>; Sun, 7 Jan 2001 11:52:25 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:1008 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136068AbRAGQwR>; Sun, 7 Jan 2001 11:52:17 -0500
Date: Sun, 7 Jan 2001 14:52:04 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
Reply-To: linux-mm@kvack.org
To: david <sector2@ihug.co.nz>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: new kernel mm
In-Reply-To: <3A580C47.94994D3A@ihug.co.nz>
Message-ID: <Pine.LNX.4.21.0101071450390.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, david wrote:

> can i rewrite the mm system in kernel's 2.2.18 to add new and
> needed functions or may be it can be a compile option old (mm
> system or new mm system) ?

Upgrade to 2.4.0  ;)

But yes, you can rewrite 2.2.18 VM all you want, that's
what the GPL is for...

Btw, which extra functions are you looking at? You may
find that some of them have already been implemented by
other people (which would save you quite a bit of work).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
