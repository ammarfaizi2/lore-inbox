Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbRENJeP>; Mon, 14 May 2001 05:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbRENJdz>; Mon, 14 May 2001 05:33:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63498 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262274AbRENJdp>; Mon, 14 May 2001 05:33:45 -0400
Subject: Re: 2.2.19 and RAID levels
To: riccardo@master.oasi.gpa.it (Riccardo Facchetti)
Date: Mon, 14 May 2001 10:30:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.10.10105141125450.1833-100000@master.oasi.gpa.it> from "Riccardo Facchetti" at May 14, 2001 11:29:13 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zEg0-0007Wx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm in the process of installing a bunch of disks on a server.
> I've read the md documentation about RAID and it seems that
> RAID5 software is not supported in 2.2 kernels. Is this correct
> or something has been done with RAID5 to make it working on
> the latest 2.2.19 ? And in this case, at which level of
> functionality ?

For 2.2 you want to update to raid-0.90. However that isnt 100% back compatible
with old old raid setups so it wasnt changed during 2.2


