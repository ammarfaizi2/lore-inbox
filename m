Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293059AbSB0XiH>; Wed, 27 Feb 2002 18:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293017AbSB0XgV>; Wed, 27 Feb 2002 18:36:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61970 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293063AbSB0XdO>; Wed, 27 Feb 2002 18:33:14 -0500
Subject: Re: Linux 2.4.19pre1-ac1
To: jonathan@daria.co.uk (Jonathan Hudson)
Date: Wed, 27 Feb 2002 23:48:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5fe3.3c7d6393.7ac52@trespassersw.daria.co.uk> from "Jonathan Hudson" at Feb 27, 2002 10:54:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gDnp-0006PU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> With 19-pre1-ac1 on a reiserfs partition I cannot patch a kernel. Patch
> >> fails with "Invalid cross-device link" or "Out of disk space".
> AF> 
> AF> I can reproduce this too on ext2, so this does not seem to be FS related. 
> 
> Likewise (reiserfs here). Numerous fuzz or outright patch failures
> with 2.4.19-pre1-ac1.

See the other mail for the questions - and reply to that too if you can. 
Right now I've not managed to reproduce it. Do you see the problem on
2.4.19-pre1 (non -ac) [that has the same reiserfs changes in as -ac does]

Alan
