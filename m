Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284370AbRL1XQ2>; Fri, 28 Dec 2001 18:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284360AbRL1XQM>; Fri, 28 Dec 2001 18:16:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284304AbRL1XPk>; Fri, 28 Dec 2001 18:15:40 -0500
Subject: Re: Linux 2.4.18-pre1
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Fri, 28 Dec 2001 23:26:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C2CCB82.7010309@athlon.maya.org> from "Andreas Hartmann" at Dec 28, 2001 08:44:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K6OG-0002D2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tested this patch and unfortunately, I have to say, it is not working
> (if it should prevent the suddenly changing time on VIA-boards).
> I have the same problem with suddenly changing time as without this patch.

It doesn't thats a seperate bug that nobody has bothered to fix yet. It
probably also explains the occasional wild time jumps a few people have
seen.
