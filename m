Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312074AbSCQRIB>; Sun, 17 Mar 2002 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312075AbSCQRHv>; Sun, 17 Mar 2002 12:07:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312074AbSCQRHd>; Sun, 17 Mar 2002 12:07:33 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: oh1mrr@nic.fi (jarmo kettunen)
Date: Sun, 17 Mar 2002 17:23:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020317135423.F2F6C1FCC5@kura.mail.jippii.net> from "jarmo kettunen" at Mar 17, 2002 03:55:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16meNU-0002xH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just patched 2.4.18 first into 2.4.19-pre3 and direct into 2.4.19-pre3-ac1.
> Couldn't get compile through because of error /linux/drivers/md/md.c.

md definitely builds. You might want to check for merge errors, or provide
the actual error to the list ?

