Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136297AbREDMPj>; Fri, 4 May 2001 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136299AbREDMPa>; Fri, 4 May 2001 08:15:30 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:17424 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S136297AbREDMPU>; Fri, 4 May 2001 08:15:20 -0400
To: linux-kernel@vger.kernel.org
Path: alphanet.ch!not-for-mail
From: Marc SCHAEFER <schaefer@alphanet.ch>
Newsgroups: alphanet.ml.linux.kernel
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Date: 4 May 2001 14:15:14 +0200
Organization: ALPHANET NF -- Not for profit telecom research
Distribution: alphanet
Message-ID: <9cu6gi$sl4$1@vulcan.alphanet.ch>
In-Reply-To: <200105041140.NAA03391@cave.bitwizard.nl>
NNTP-Posting-Host: vulcan.alphanet.ch
X-Newsreader: TIN [UNIX 1.3 unoff BETA 970705; i586 Linux 2.0.38]
Xref: alphanet.ch alphanet.ml.linux.kernel:202066
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:
> during boot. I can then reshuffle my disk to have that 50M of data at
> the beginning and reading all that into 50M of cache, I can save

Wasn't that one of the goals of the LVM project, along snapshots and
block-level HSM ?

