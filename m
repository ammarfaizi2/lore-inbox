Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSIZQcf>; Thu, 26 Sep 2002 12:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSIZQcf>; Thu, 26 Sep 2002 12:32:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30641 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261331AbSIZQce>; Thu, 26 Sep 2002 12:32:34 -0400
Date: Thu, 26 Sep 2002 13:37:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <Pine.LNX.4.44.0209260934170.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209261336360.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Thunder from the hill wrote:
> On Thu, 26 Sep 2002, Rik van Riel wrote:
> > If I were you, I'd take a large piece of paper and make
> > a drawing of what the data structure looks like and what
> > the various macros/functions are supposed to do.
>
> Well, I know what they _should_ do. But I don't know what I should
> initialize an empty list entry to.

And now you contradict yourself ;)

Please make a detailed picture of the data structure on
a piece of paper so you can check the code against the
picture and see if it really is doing the right thing.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

