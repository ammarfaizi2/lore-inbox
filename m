Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSBMXfx>; Wed, 13 Feb 2002 18:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSBMXfa>; Wed, 13 Feb 2002 18:35:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289140AbSBMXfT>; Wed, 13 Feb 2002 18:35:19 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
To: rlake@colabnet.com (Rob Lake)
Date: Wed, 13 Feb 2002 23:49:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6AF523.9070703@colabnet.com> from "Rob Lake" at Feb 13, 2002 07:52:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16b99D-0006p4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-2.4.13-ac8 (patched from linux-2.4.13 with ac8 patch, if it 
> matters).  Each time I load the i2o_block module, there is a a kernel 
> panic.  Running the output through ksymoops produced the what's below - 
> hopefully the ???? are supposed to be there.  At first I tried with i2o 
> compiled into kernel; It had detected the raid card, but panic'd soon after.

Use either 2.4.9 Red Hat kernel trees or 2.4.18-rc1 and all should be well.
