Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRLBQLT>; Sun, 2 Dec 2001 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRLBQLJ>; Sun, 2 Dec 2001 11:11:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280114AbRLBQLF>; Sun, 2 Dec 2001 11:11:05 -0500
Subject: Re: Filesystem corruptions etc. - Which is the last safe kernel?
To: jb3@freemail.hu (Balazs Javor)
Date: Sun, 2 Dec 2001 16:19:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel)
In-Reply-To: <020801c17b3d$574fbeb0$0501a8c0@llama> from "Balazs Javor" at Dec 02, 2001 03:26:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZLT-0003kF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now the question is, is any of the 2.4.x kernels safe to use?
> And why is it that supposedly released and stable kernels can have such
> serious issues?

Because you misunderstand the release process. Extensive QA is what the 
vendors are doing on top of releases. 2.4.16 seems fine if you want ext3.


