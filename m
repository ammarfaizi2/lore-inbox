Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJUPf6>; Sun, 21 Oct 2001 11:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276285AbRJUPft>; Sun, 21 Oct 2001 11:35:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276255AbRJUPfc>; Sun, 21 Oct 2001 11:35:32 -0400
Subject: Re: 2.2.x process limits (NR_TASKS)?
To: bgerst@didntduck.org (Brian Gerst)
Date: Sun, 21 Oct 2001 16:42:14 +0100 (BST)
Cc: gkade@bigbrother.net (Gregory Ade), linux-kernel@vger.kernel.org
In-Reply-To: <3BCF27D5.CE4C53DE@didntduck.org> from "Brian Gerst" at Oct 18, 2001 03:04:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKju-0006nt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.2.x has a hard limit of 512 tasks on the x86 because it uses hardware

About 3800 actually - the default compile value can be upped
