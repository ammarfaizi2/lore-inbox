Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277873AbRJWQKP>; Tue, 23 Oct 2001 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJWQKF>; Tue, 23 Oct 2001 12:10:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277867AbRJWQJx>; Tue, 23 Oct 2001 12:09:53 -0400
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
To: yakker@alacritech.com (Matt D. Robinson)
Date: Tue, 23 Oct 2001 17:16:23 +0100 (BST)
Cc: mhw@wittsend.com (Michael H. Warfield), linux-kernel@vger.kernel.org
In-Reply-To: <3BD501AF.7B4D7645@alacritech.com> from "Matt D. Robinson" at Oct 22, 2001 10:35:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4E3-0006Ph-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't be surprised if someone creates a LHQL process or
> business to qualify binary drivers on supportable kernels from
> distributions.  I'd give it about a year.

For the vendors I think that is a reasonable expectation. Right now I know
of no vendor who supports a binary only driver at all. Its only feasible to
do that with partnership agreements, complex piles of SLA's that of course
all turn out useless when the binary vendor goes bankrupt (which happens
ask any Aureal user)

Alan
