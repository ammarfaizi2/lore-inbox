Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291642AbSBNNkb>; Thu, 14 Feb 2002 08:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291649AbSBNNkW>; Thu, 14 Feb 2002 08:40:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58642 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291642AbSBNNkL>; Thu, 14 Feb 2002 08:40:11 -0500
Subject: Re: Kernel 2.2.20 RAM requirements
To: p_gortmaker@yahoo.com (Paul Gortmaker)
Date: Thu, 14 Feb 2002 13:54:03 +0000 (GMT)
Cc: pitt@gmx.at (Christoph Pittracher), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C6BB872.11A067BC@yahoo.com> from "Paul Gortmaker" at Feb 14, 2002 08:15:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bMKp-0008Vw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you try bzImage it will work.  Saw this just recently on a low
> mem machine (LILO/loadlin) & haven't had a chance to investigate
> further.

The zImage/bzImage one should be fixed in 2.2.21pre 
