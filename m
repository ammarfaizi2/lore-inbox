Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290204AbSALBUN>; Fri, 11 Jan 2002 20:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290203AbSALBUD>; Fri, 11 Jan 2002 20:20:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56843 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290202AbSALBTn>; Fri, 11 Jan 2002 20:19:43 -0500
Subject: Re: CIPE vs. GPLONLY_
To: brian@worldcontrol.com
Date: Sat, 12 Jan 2002 01:31:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020112010317.GA1765@top.worldcontrol.com> from "brian@worldcontrol.com" at Jan 11, 2002 05:03:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PD12-0000wY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> running CIPE 1.5.2 I get the error above.  Should I be bother the
> CIPE people with this?  Or is this some kernel thingy that needs
> to be dealt with?

Add

	MODULE_LICENSE("GPL");

to the cipe code and all will be well
