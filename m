Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVBURqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVBURqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVBURqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:46:33 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:42634 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262055AbVBURqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:46:31 -0500
Date: Mon, 21 Feb 2005 18:46:23 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Message-ID: <20050221174623.GA3619@merlin.emma.line.org>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu> <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu> <cv36kk$54m$1@gatekeeper.tmr.com> <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com> <1108998023.15518.93.camel@localhost.localdomain> <58cb370e0502210725520eee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0502210725520eee3@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005, Bartlomiej Zolnierkiewicz wrote:

> Speaking about ide-scsi, it will be undeprecated after I fix the locking.
> Rationale is that ide-scsi is _much_ simpler than ide-{cd,tape}.
> [ although it doesn't support all the hardware that ide-{cd,tape} do ]

Good to read that. I've always wondered why Linux went backwards when all
other systems added atapicam (FreeBSD) and similar, now I can stop
wondering.

-- 
Matthias Andree
