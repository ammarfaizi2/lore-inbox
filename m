Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276977AbRJCUwl>; Wed, 3 Oct 2001 16:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276978AbRJCUwc>; Wed, 3 Oct 2001 16:52:32 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:31242 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S276977AbRJCUwO>; Wed, 3 Oct 2001 16:52:14 -0400
Date: Wed, 3 Oct 2001 16:52:22 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Sujal Shah <sshah@progress.com>, linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <20011003211321.G3638@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC it was something like 18MB/s without and 30MB/s with write

for a current Maxtor 60G 5400 RPM UDMA100 disk, 2.4.10, ext2,
I just measured: 7 MBps with -W0, vs 27 MB/s with -W1.

