Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbRENTdM>; Mon, 14 May 2001 15:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262417AbRENTdC>; Mon, 14 May 2001 15:33:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262409AbRENTc5>; Mon, 14 May 2001 15:32:57 -0400
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
To: jgolds@resilience.com (Jeff Golds)
Date: Mon, 14 May 2001 20:29:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B002D61.191C03C@resilience.com> from "Jeff Golds" at May 14, 2001 12:09:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zO2C-0001GQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I installed the 2.4.4 kernel on a dual P3-733 system with 1 GB of ECC RAM and found that /proc/meminfo reports back only 899MB of RAM.  The 2.4.2 kernel (with RedHat patches from the 7.1 release) worked fine as did the 2.4.0 kernel (with RedHat patches from the 7.0 release).#

Built it with 4GB support. 1Gb actually works out at about 900Mb and possibly
wants renaming..
