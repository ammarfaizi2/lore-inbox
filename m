Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135666AbREFMz2>; Sun, 6 May 2001 08:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135668AbREFMzL>; Sun, 6 May 2001 08:55:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135666AbREFMzH>; Sun, 6 May 2001 08:55:07 -0400
Subject: Re: CML2 design philosophy heads-up
To: esr@thyrsus.com
Date: Sun, 6 May 2001 13:58:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> from "Eric S. Raymond" at May 05, 2001 07:27:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wO7g-000240-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # These were separate questions in CML1
> derive MAC_SCC from MAC & SERIAL
> derive MAC_SCSI from MAC & SCSI
> derive SUN3_SCSI from (SUN3 | SUN3X) & SCSI

Not all Mac's use the SCC if they have serial
Not all Mac's use the same SCSI controller

Alan

