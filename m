Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSKUWge>; Thu, 21 Nov 2002 17:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSKUWge>; Thu, 21 Nov 2002 17:36:34 -0500
Received: from mail44-s.fg.online.no ([148.122.161.44]:35498 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP
	id <S265099AbSKUWgc>; Thu, 21 Nov 2002 17:36:32 -0500
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Kent Borg <kentborg@borg.org>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <200211211920.07414.m.c.p@wolk-project.de>
From: Harald Arnesen <harald@skogtun.org>
Date: Thu, 21 Nov 2002 23:43:25 +0100
In-Reply-To: <200211211920.07414.m.c.p@wolk-project.de> (Marc-Christian
 Petersen's message of "Thu, 21 Nov 2002 19:20:07 +0100")
Message-ID: <87fztuczn6.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

> BUGS AND LIMITATIONS
>        As  of  Linux  2.2,  the  `c',  's',  and `u' attribute are not honored
>        by the kernel filesystem code. These attributes will be implemented in
>        a future ext2 fs version.
>
> Curious to see when the future is ;)

Anyway, it would be false security. Any government agency (or IBAS in
Norway) may be able to reconstruct any data on your hd, or they may not.
But you can't know it. So if you _really_ want to have private data on
you computer, strong encryption is the only solution. And be sure that
every temporary file is encrypted!
-- 
Hilsen Harald.
