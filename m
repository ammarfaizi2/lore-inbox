Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRACPxS>; Wed, 3 Jan 2001 10:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132157AbRACPxI>; Wed, 3 Jan 2001 10:53:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52209 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131830AbRACPwz>; Wed, 3 Jan 2001 10:52:55 -0500
Date: Wed, 3 Jan 2001 13:21:57 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] drop-behind fix for generic_file_write
In-Reply-To: <Pine.LNX.4.21.0101031256040.1403-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101031321200.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Rik van Riel wrote:

> the following (trivial) patch fixes drop-behind behaviour
> in generic_file_write to only drop fully written pages.

OK, please ignore. It is already in  prerelease-diff
in the testing/ directory .. ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
