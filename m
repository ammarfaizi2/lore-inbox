Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273584AbRIQMT4>; Mon, 17 Sep 2001 08:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273585AbRIQMTr>; Mon, 17 Sep 2001 08:19:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273584AbRIQMTg>; Mon, 17 Sep 2001 08:19:36 -0400
Subject: Re: Linux 2.2.20pre10
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 17 Sep 2001 13:24:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010916230852.E24067@mikef-linux.matchmail.com> from "Mike Fedyk" at Sep 16, 2001 11:08:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ixRY-00072A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know the Ingo's raid patch hasn't been included because of tool
> compatibility problems.  Has anyone thought of having both versions in the
> 2.2 kernel?  Would this be trivial, or something that would change too much
> for 2.2?

It wont be happening in the base 2.2 code.

> I've been compiling in Andre's EIDE patch for months, without any problems
> on x86.  Except for an #include error on PPC.  I have a patch, but I can't
> sent attach now because the patch is on a computer that is off at the moment...

And that one definitely wont
