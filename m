Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbSIZTzH>; Thu, 26 Sep 2002 15:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSIZTzH>; Thu, 26 Sep 2002 15:55:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52192 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261500AbSIZTzG>; Thu, 26 Sep 2002 15:55:06 -0400
Date: Thu, 26 Sep 2002 17:00:03 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209261659150.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Thunder from the hill wrote:
> On Thu, 26 Sep 2002, Rik van Riel wrote:
> > On Thu, 26 Sep 2002, Thunder from the hill wrote:
> > In the case of slist_del() you HAVE to know it.
> >
> > Think about removing a single entry from the middle of
> > the list ... the entries before and after need to stay
> > on the list.
>
> 2 solutions without list head:

Have you thought about how to _use_ a list without a list head ?

How are you going to find the list ?

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

