Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314516AbSEFPTl>; Mon, 6 May 2002 11:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSEFPTh>; Mon, 6 May 2002 11:19:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314512AbSEFPTd>; Mon, 6 May 2002 11:19:33 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dank@kegel.com
Date: Mon, 6 May 2002 16:38:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3CD560FB.C6736001@kegel.com> from "Dan Kegel" at May 05, 2002 09:42:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174kZE-0005XD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Caveat: I'm not much of a kernel hacker.]
> My only concern with kbuild 2.5 was the lack of modversions,
> but since Richard is promising to add them in before the

Keith  ITYM

> distros need them, I would have no qualms about kbuild 2.5
> totally replacing the old build system for the next 2.5 kernel.
> I'm sick and tired of 'make dep'.
> 
> What does Alan Cox think?

I believe we should end up with working Modversions. If they get disabled
for a bit while it gets there its no different to the state of IDE, the
block layer and many scsi drivers right now.

Alan
