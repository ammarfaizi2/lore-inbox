Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132664AbRC2EWZ>; Wed, 28 Mar 2001 23:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132671AbRC2EWP>; Wed, 28 Mar 2001 23:22:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33805 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132664AbRC2EWB>; Wed, 28 Mar 2001 23:22:01 -0500
Subject: Re: Linux-2.4.2-ac27 - read on /proc/bus/pci/devices never finishes after rmmod aic7xxx
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 29 Mar 2001 05:21:37 +0100 (BST)
Cc: jeffrey.hundstad@mnsu.edu (Jeffrey Hundstad),
   linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
   alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <200103290320.f2T3KNs02696@aslan.scsiguy.com> from "Justin T. Gibbs" at Mar 28, 2001 08:20:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14iTwJ-00075c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What version of the aic7xxx driver is embedded in 2.4.2-ac27?  This
> particular issue was fixed just after 6.1.5 was released.

The last patch you sent to me + small other fixups for aicdb.h. I dont have
time to chase after peoples drivers. If you want a newer aic7xxx in -ac just
mail me a diff to update to it

