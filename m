Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRJXPVE>; Wed, 24 Oct 2001 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278567AbRJXPUx>; Wed, 24 Oct 2001 11:20:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278566AbRJXPUs>; Wed, 24 Oct 2001 11:20:48 -0400
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
To: timtas@dplanet.ch (Tim Tassonis)
Date: Wed, 24 Oct 2001 16:27:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15wPed-0000HM-00@lttit> from "Tim Tassonis" at Oct 24, 2001 05:09:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wPwW-0001oq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to create a partition of 2GB using fdisk or parted, I get the
> error "File size limit exceeded (core dumped)". I already read about this
> error on the mailing list, but sadly not of any solution.

Make sure you have limits set right and a new enough glibc. 
