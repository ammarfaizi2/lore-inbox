Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSFOPtj>; Sat, 15 Jun 2002 11:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSFOPti>; Sat, 15 Jun 2002 11:49:38 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:48072 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315427AbSFOPth>; Sat, 15 Jun 2002 11:49:37 -0400
Date: Sat, 15 Jun 2002 10:49:37 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [trivial PATCH] config
In-Reply-To: <UTC200206151505.g5FF53g26435.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0206151048300.7155-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> % make
> ***
> *** You have not yet configured your kernel!
> *** Please run "make xconfig/menuconfig/config/oldconfig"
> ***
> make: *** [.config] Error 1
> % make xconfig/menuconfig/config/oldconfig
> ***
> *** You have not yet configured your kernel!
> *** Please run "make xconfig/menuconfig/config/oldconfig"
> ***
> make: *** [.config] Error 1

Okay, I was lazy ;) I'll submit your patch.

Thanks,
--Kai


