Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282866AbRLBM4u>; Sun, 2 Dec 2001 07:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRLBM4l>; Sun, 2 Dec 2001 07:56:41 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28425 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282866AbRLBM40>;
	Sun, 2 Dec 2001 07:56:26 -0500
Date: Sun, 2 Dec 2001 10:19:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Stanislav Meduna <stano@meduna.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <200112020801.fB281Wt07893@meduna.org>
Message-ID: <Pine.LNX.4.33L.0112021019240.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Stanislav Meduna wrote:

> The need of the VM change is probably a classical example -
> why was it not clear at the 2.4.0-pre1, that the current
> implementation is broken to the point of no repair?

It wasn't broken to the point of no repair until Linus
started integrating use-once and dropping bugfixes.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

