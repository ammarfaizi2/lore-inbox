Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSD0TmY>; Sat, 27 Apr 2002 15:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSD0TmX>; Sat, 27 Apr 2002 15:42:23 -0400
Received: from mustard.heime.net ([194.234.65.222]:53378 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S314433AbSD0TmV>; Sat, 27 Apr 2002 15:42:21 -0400
Date: Sat, 27 Apr 2002 21:42:10 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Matthew M <matthew.macleod@btinternet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
In-Reply-To: <m171Yag-000Ga6C@Wasteland>
Message-ID: <Pine.LNX.4.44.0204272141010.2833-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Matthew M wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
> > Sorry if this is a FAQ, but where's the microcode.dat supposed to be
> > placed? I can't find any information about that in the doc.
> 
> /usr/share/misc/microcode.dat

hm... but... Isn't the microcode update being done during kernel boot? 
I rarely have a system set up with /usr on the same fs as /

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

