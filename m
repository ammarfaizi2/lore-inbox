Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132495AbRAGN4j>; Sun, 7 Jan 2001 08:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRAGN43>; Sun, 7 Jan 2001 08:56:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132495AbRAGN4M>; Sun, 7 Jan 2001 08:56:12 -0500
Subject: Re: [PATCH] new bug report script
To: juchem@uni-mannheim.de
Date: Sun, 7 Jan 2001 13:58:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101070808560.7104-100000@gandalf.math.uni-mannheim.de> from "Matthias Juchem" at Jan 07, 2001 08:48:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGKh-0002gh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a patch against 2.4.0. It introduces a new bug reporting script
> (scripts/bugreport.pl) that tries to simplify bug reporting for users. I
> have also added a small hint to this script to REPORTING-BUGS.

The kernel doesnt require perl. I don't want to add a dependancy on perl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
