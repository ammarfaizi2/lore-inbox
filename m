Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRI2O02>; Sat, 29 Sep 2001 10:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276510AbRI2O0S>; Sat, 29 Sep 2001 10:26:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39183 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276509AbRI2O0L>; Sat, 29 Sep 2001 10:26:11 -0400
Subject: Re: Linux 2.4.9-ac17
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Sat, 29 Sep 2001 15:31:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010928190040.C29756@mikef-linux.matchmail.com> from "Mike Fedyk" at Sep 28, 2001 07:00:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nL8x-00026y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You (-ac) and linus (2.4.10 and eventual .11-pre) are split on the VM from
> > Rik and Andreas, correct?
> 
> Right, which VM will be in 2.4.10-ac1?

Rik's vm and also none of the horrible page cache/block device hackery that
belongs in 2.5. I actually use the trees I release and I want to keep my
machines working
