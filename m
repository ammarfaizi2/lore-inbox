Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSEHTLM>; Wed, 8 May 2002 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSEHTLK>; Wed, 8 May 2002 15:11:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314906AbSEHTLH>; Wed, 8 May 2002 15:11:07 -0400
Subject: Re: info/patch update needed, Adaptec 2400a, dpt_i20
To: david+cert@blue-labs.org (David Ford)
Date: Wed, 8 May 2002 20:29:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3CD96E25.9050204@blue-labs.org> from "David Ford" at May 08, 2002 02:27:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175X8E-0002Cn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a friend who needs driver information.  Is the 2.4.6 driver that 
> Adaptec lists at http://linux.adaptec.com/linux_raid_unsupported.html 
> the most current version for this controller?

Adaptec cleaned up the driver code massively and the dpt_i2o driver is now
standard in the Linux kernel tree
