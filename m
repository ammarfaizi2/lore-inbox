Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129937AbQKIW5B>; Thu, 9 Nov 2000 17:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbQKIW4w>; Thu, 9 Nov 2000 17:56:52 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:56559 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130378AbQKIW4g>; Thu, 9 Nov 2000 17:56:36 -0500
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.10.10011091442570.26422-100000@main.cyclades.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 09 Nov 2000 14:56:16 -0800
In-Reply-To: <Pine.LNX.4.10.10011091442570.26422-100000@main.cyclades.com>
Message-ID: <m3em0kvjov.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos <lists@cyclades.com> writes:

> Where in the src tree can I find (or what is) the command to generate a
> patch file from two Linux kernel src trees, one being the original and the
> other being the newly changed one??
> I've tried 'diff -ruN', but that does diff's on several files that could
> stay out of the comparison (such as the files in include/config, .files,
> etc.).

use the dontdiff file from tigran with -X option of diff at :

http://www.moses.uklinux.net/patches/dontdiff

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
