Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSDEMuw>; Fri, 5 Apr 2002 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDEMum>; Fri, 5 Apr 2002 07:50:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312532AbSDEMua>; Fri, 5 Apr 2002 07:50:30 -0500
Subject: Re: COMPILE BUG: SiS DRM Support
To: bnuske@cs.rmit.edu.au (Brett Nuske)
Date: Fri, 5 Apr 2002 14:07:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.33.0204052211080.25614-100000@numbat.cs.rmit.edu.au> from "Brett Nuske" at Apr 05, 2002 10:22:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tTQs-0008HE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I have been trying to compile SiS DRM support
> with the 2.4.18 kernel (have tried both module
> and in the kernel) but to no avail. When built

You must include SiS frame buffer support
