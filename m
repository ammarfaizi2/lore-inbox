Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSDFRgl>; Sat, 6 Apr 2002 12:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312644AbSDFRgk>; Sat, 6 Apr 2002 12:36:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15632 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312643AbSDFRgj>; Sat, 6 Apr 2002 12:36:39 -0500
Subject: Re: Re: Re: faster boots?
To: joeja@mindspring.com
Date: Sat, 6 Apr 2002 18:53:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.0994.1018030106.0.22918200@webmail.atl.earthlink.net> from "joeja@mindspring.com" at Apr 05, 2002 01:08:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tuNx-0002LL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what is the best way in Linux to figure out what you can remove from the 
> kernel to make it smaller and boot hopefully faster on low end machines?

Say "M" to everything that isnt your root file system or directly dependant
on it. The whole "build a custom kernel" thing is mostly a red herring.
