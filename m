Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279900AbRJ3JAR>; Tue, 30 Oct 2001 04:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279897AbRJ3JAI>; Tue, 30 Oct 2001 04:00:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279821AbRJ3I7t>; Tue, 30 Oct 2001 03:59:49 -0500
Subject: Re: Nasty suprise with uptime
To: jjs@lexus.com (J Sloan)
Date: Tue, 30 Oct 2001 09:06:26 +0000 (GMT)
Cc: mfedyk@matchmail.com (Mike Fedyk),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3BDDE422.938C1D95@lexus.com> from "J Sloan" at Oct 29, 2001 03:20:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yUqo-0005pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Say, if the uptime field were unsigned it could
> reach 995 days uptime before wraparound -

Only on a 33bit processor - and those are kind of rare
