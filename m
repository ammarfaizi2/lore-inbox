Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292378AbSBUN3q>; Thu, 21 Feb 2002 08:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292372AbSBUN3g>; Thu, 21 Feb 2002 08:29:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34564 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292378AbSBUN3P>; Thu, 21 Feb 2002 08:29:15 -0500
Subject: Re: Swap / thrashing / fatal crash
To: super.aorta@ntlworld.com (SA)
Date: Thu, 21 Feb 2002 13:43:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020221103449.YCUZ22101.mta07-svc.ntlworld.com@there> from "SA" at Feb 21, 2002 10:41:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtVe-0006wq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I seem to recall that under k2.2.xx this sort of thing would end up with 
> something getting a signal -KILL rather than thrashing.

It should do - you are running a very old 2.4 kernel though and one with
known to be fairly poor vm behaviour

