Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbSJAQxX>; Tue, 1 Oct 2002 12:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSJAQwX>; Tue, 1 Oct 2002 12:52:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54933 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261750AbSJAQvl>; Tue, 1 Oct 2002 12:51:41 -0400
Date: Tue, 1 Oct 2002 13:56:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Daniel Phillips <phillips@arcor.de>
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, <zippel@linux-m68k.org>,
       <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 mm trouble [possible lru race]
In-Reply-To: <E17wOxJ-0005uR-00@starship>
Message-ID: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Daniel Phillips wrote:
> On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:

> > no preempt or anything fancy, m68k vanila 2.4.19 (well almost).
>
> Vanilla would be CONFIG_SMP=y, is that what you have?

Somehow I doubt Linux supports m68k SMP machines ;)

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

