Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277859AbRJWQMz>; Tue, 23 Oct 2001 12:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277861AbRJWQMp>; Tue, 23 Oct 2001 12:12:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35590 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277859AbRJWQMf>; Tue, 23 Oct 2001 12:12:35 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
To: sgy@amc.com.au (Stuart Young)
Date: Tue, 23 Oct 2001 17:19:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20011023154226.00a20ba0@mail.amc.localnet> from "Stuart Young" at Oct 23, 2001 04:15:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4Ga-0006Q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This kernel oops is totally reproducible (on every occasion) in 2.4.9, 
> 2.4.10, and 2.4.12. I have not tried earlier kernels in the 2.4 series, but 
> have tried 2.2.19pre17 (will explain other SiS Chipset funny business in 
> another message). All kernels were compiled while the machine was running 
> 2.2.19pre17.

Does this problem go away if you build the driver modular.  Im wondering
if it matches another mysterious and similar report
