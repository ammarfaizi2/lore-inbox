Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSFPCxT>; Sat, 15 Jun 2002 22:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSFPCxS>; Sat, 15 Jun 2002 22:53:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39116 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315806AbSFPCxS>; Sat, 15 Jun 2002 22:53:18 -0400
Date: Sat, 15 Jun 2002 21:53:00 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John covici <covici@ccs.covici.com>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21 make problem
In-Reply-To: <15627.63040.620383.846497@ccs.covici.com>
Message-ID: <Pine.LNX.4.44.0206152149190.7247-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Jun 2002, John covici wrote:

> I did the mrproper then the make with the clean and then the make
> without the clean in that order and still no results.

Could you mail me your .config and the exact commands which lead to the
failure (off-list). Actually, can you send your top-level Makefile as
well.

Can you reproduce the problem on an clean kernel.org tree (no further
patches applied? I suspect something went wrong with the extra patches you 
applied.

--Kai

