Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285430AbRLGIls>; Fri, 7 Dec 2001 03:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285432AbRLGIli>; Fri, 7 Dec 2001 03:41:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285430AbRLGIl0>; Fri, 7 Dec 2001 03:41:26 -0500
Subject: Re: Where's the vfsv0 quota?
To: robe@amd.co.at (Michael Renner)
Date: Fri, 7 Dec 2001 08:50:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112062150160.24250-100000@trottelkunde.amd.co.at> from "Michael Renner" at Dec 07, 2001 01:56:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CGhy-00053K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any plans to incorporate the vfsv0 quota code into the 2.4
> and/or 2.5 tree? The last kernel which supported the new quota format was
> 2.4.13-ac8 afaik.

2.5 yes. For 2.4 its a bit tricky to do so because it would mean a change
of tools during a stable tree. So it has to stay as an add on I suspect.
