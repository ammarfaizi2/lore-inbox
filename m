Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318987AbSIDAtK>; Tue, 3 Sep 2002 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSIDAtK>; Tue, 3 Sep 2002 20:49:10 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:28805 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318987AbSIDAtJ>; Tue, 3 Sep 2002 20:49:09 -0400
Date: Tue, 3 Sep 2002 21:53:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
In-Reply-To: <20020904004028.GS888@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0209032152210.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, William Lee Irwin III wrote:

> count_list() appears to be the largest consumer of cpu after this is
> done, or so say the profiles after running updatedb by hand on
> 2.5.33-mm1 on a 900MHz P-III T21 Thinkpad with 256MB of RAM.
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Maybe it's old news. Just thought I'd try running a test on something
> tiny for once. (new kbd/mouse config options were a PITA BTW)

You've got an interesting idea of tiny ;)

Somehow I have the idea that the Linux users with 64 MB
of RAM or less have _more_ memory together than what's
present in all the >8GB Linux servers together...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

