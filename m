Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRAaWS5>; Wed, 31 Jan 2001 17:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129284AbRAaWSr>; Wed, 31 Jan 2001 17:18:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129128AbRAaWSc>; Wed, 31 Jan 2001 17:18:32 -0500
Subject: Re: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
To: yourst@mit.edu (Matt Yourst)
Date: Wed, 31 Jan 2001 22:18:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A788DDE.AF82E72F@mit.edu> from "Matt Yourst" at Jan 31, 2001 05:12:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O5a9-0003Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reference to `__buggy_fxsr_alignment'" when trying to do the final

Dont use pgcc 2.95, at least until they fix that 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
