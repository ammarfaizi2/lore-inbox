Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCaPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCaPkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCaPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:40:17 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:40125 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261442AbVCaPkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:40:10 -0500
Date: Thu, 31 Mar 2005 17:40:39 +0200
From: DervishD <lkml@dervishd.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Mariusz Mazur <mmazur@kernel.pl>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
Message-ID: <20050331154039.GB6468@DervishD>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Mariusz Mazur <mmazur@kernel.pl>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050330162114.GA1028@DervishD> <200503302240.08200.mmazur@kernel.pl> <20050331074526.GA8614@DervishD> <200503311426.48435.mmazur@kernel.pl> <20050331141726.GA654@DervishD> <Pine.LNX.4.62.0503311659040.7825@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0503311659040.7825@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jesper :)

 * Jesper Juhl <juhl-lkml@dif.dk> dixit:
> > > And I don't see any point in LFS suggesting using raw kernel
> > > headers to compile glibc
> >     I don't know their reasons because I haven't read any rationale
> > (if any exists at all). Anyway, I've used LLH (including the scsi
> http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html seems to have a 
> bearing on what you are discussing - just FYI.

    Not exactly. My doubt is not about whether use symlinks to linux
and asm in the linux kernel or not, is about using what glibc people
prefer or seem to prefer (raw kernel headers) or using llh. I know
that I don't have to use the current kernel headers in /usr/include,
but the ones used when compiling my libc or (better) llh.

    Thanks anyway :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
