Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRIAOKZ>; Sat, 1 Sep 2001 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRIAOKP>; Sat, 1 Sep 2001 10:10:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24324 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270257AbRIAOKA>;
	Sat, 1 Sep 2001 10:10:00 -0400
Date: Sat, 1 Sep 2001 11:10:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
In-Reply-To: <200109011455.f81Ethw00685@vegae.deep.net>
Message-ID: <Pine.LNX.4.33L.0109011109220.20664-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001, Samium Gromoff wrote:
>  ANdreas Dilger wrote:
> > Win2K even abstracts all SMP/UP code into a module (the HAL) and loads this
> > at boot, thus using the same kernel for both.

>     the only possibility of this shows how ugly is SMP in win2k...

Not necessarily. More likely the difference between SMP and
UP is marketing-only and both have the overhead of SMP
locking, etc..

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

