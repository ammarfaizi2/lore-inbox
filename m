Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSETJMr>; Mon, 20 May 2002 05:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314684AbSETJMq>; Mon, 20 May 2002 05:12:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:56472 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314395AbSETJMq>;
	Mon, 20 May 2002 05:12:46 -0400
Date: Mon, 22 Apr 2002 23:44:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of setup_arch() for 2.4.19pre7
Message-ID: <20020422214441.GA6837@elf.ucw.cz>
In-Reply-To: <200204181817.g3IIHJQ02901@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please consider this patch for inclusion into the next 2.4 release.  
> It was accepted into the 2.4.19pre6aa1, with slight modifications 
> by Andrea that I have incorporated into this version of my patch.
> 
> This patch restructures setup_arch() for i386 to make it easier to
> include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
> working on.  It also makes setup_arch() easier to read.  

Should not this go to 2.5, instead?

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
