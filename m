Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316525AbSEPAOV>; Wed, 15 May 2002 20:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316526AbSEPAOU>; Wed, 15 May 2002 20:14:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316525AbSEPAOT>; Wed, 15 May 2002 20:14:19 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: woody@co.intel.com (Woodruff, Robert J)
Date: Thu, 16 May 2002 01:32:09 +0100 (BST)
Cc: russ@elegant-software.com ('Russell Leighton'), Tony.P.Lee@nokia.com,
        wookie@osdl.org, alan@lxorguk.ukuu.org.uk, lmb@suse.de,
        woody@co.intel.com (Woodruff Robert J), linux-kernel@vger.kernel.org,
        zaitcev@redhat.com
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0BFB7E85@orsmsx108.jf.intel.com> from "Woodruff, Robert J" at May 15, 2002 04:58:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1789Bh-0003D8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so someone could invent a new address family for sockets,
> say AF_INFINIBANDO, that is much more light weight than the existing TCP/IP
> stack.
> Thus with a small change to the application, a good performance increase can
> be attained.

Shouldn't be too hard. It looks like its basically AF_PACKET combined with
the infiniband notions of security.
