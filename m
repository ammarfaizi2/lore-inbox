Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280083AbRJaGLj>; Wed, 31 Oct 2001 01:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280085AbRJaGL3>; Wed, 31 Oct 2001 01:11:29 -0500
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:19727
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S280083AbRJaGLU>; Wed, 31 Oct 2001 01:11:20 -0500
Date: Wed, 31 Oct 2001 00:11:08 -0600 (CST)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <Ethan@stinkfoot.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PPC kernel ide modules failing
In-Reply-To: <3BDF899D.7070503@stinkfoot.org>
Message-ID: <Pine.LNX.4.33.0110310010060.15085-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Ethan@stinkfoot.org wrote:
> I thought that I'd mention that on recent PPC kernels the ide modules
> won't load:
> /lib/modules/2.4.14-pre3/kernel/drivers/ide/ide-mod.o: unresolved symbol
> ppc_generic_ide_fix_driveid

use Alan's tree, or the bk tree.

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

