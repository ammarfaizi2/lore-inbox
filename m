Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313438AbSDGTZe>; Sun, 7 Apr 2002 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313440AbSDGTZd>; Sun, 7 Apr 2002 15:25:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9992 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313438AbSDGTZc>; Sun, 7 Apr 2002 15:25:32 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: movement@marcelothewonderpenguin.com (John Levon)
Date: Sun, 7 Apr 2002 20:42:48 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407192324.GA21491@compsoc.man.ac.uk> from "John Levon" at Apr 07, 2002 08:23:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIYq-0006Xf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll genuinely take on board advice on how I can profile all the system
> via x86 perf counters efficiently without having to patch the kernel.
> The old way just uses sys_call_table. So what do I do now ?

The obvious thing is to represent it as a device. I'm not familiar enough
with the existing perfctr work to know how well that works out.

