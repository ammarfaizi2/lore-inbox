Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRDDSe7>; Wed, 4 Apr 2001 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRDDSet>; Wed, 4 Apr 2001 14:34:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129464AbRDDSei>; Wed, 4 Apr 2001 14:34:38 -0400
Subject: Re: nfs performance at high loads
To: kapish@ureach.com
Date: Wed, 4 Apr 2001 19:35:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104041828.OAA22823@www21.ureach.com> from "Kapish K" at Apr 04, 2001 02:28:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ks8G-0002Uk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	We have been seeing some problems with running nfs benchmarks
> at very high loads and were wondering if somebody could show
> some pointers to where the problem lies.
> 	The system is a 2.4.0 kernel on a 6.2 Red at distribution ( so

Use 2.2.19. The 2.4 VM is currently too broken to survive high I/O benchmark
tests without going silly

