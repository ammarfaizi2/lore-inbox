Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136504AbRD3Rco>; Mon, 30 Apr 2001 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136502AbRD3Rce>; Mon, 30 Apr 2001 13:32:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9737 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136500AbRD3Rc0>; Mon, 30 Apr 2001 13:32:26 -0400
Subject: Re: OOM stupidity
To: klink@clouddancer.com
Date: Mon, 30 Apr 2001 18:34:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010429123454.364E06808@mail.clouddancer.com> from "Colonel" at Apr 29, 2001 05:34:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uHYi-0008JI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Swap was hardly filled up, and remember it's the 2xRAM swap size now!
> Has Linux been too eager to accept recent windows converts (and prior
> to their recovery from that brain damage) and lost it's sharp edge of

The Linux tree OOM trigger is way wrong right now. We know

> Where is a patch to allow the sensible OOM I had in prior kernels?
> (cause this crap is getting pitched)

Try -ac (or 2.2.19 for now)

