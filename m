Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292602AbSBZBY0>; Mon, 25 Feb 2002 20:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSBZBXf>; Mon, 25 Feb 2002 20:23:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292605AbSBZBXX>; Mon, 25 Feb 2002 20:23:23 -0500
Subject: Re: Linux 2.4.18-ac1
To: andersen@codepoet.org
Date: Tue, 26 Feb 2002 01:38:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020226005144.GA31456@codepoet.org> from "Erik Andersen" at Feb 25, 2002 05:51:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fWZB-00077P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 2.4.18-ac1
> > o	Merge with 2.4.18 proper
> 
> Do you plan on pushing the ide driver updates to Marcelo?
> It would be great to see ide-20020215 pulled into 2.4.x,

Pre2/pre3 - The 19p1 merge means a merge against the generic ll_rw_blk change
in 19p1 and the ide floppy change - I want to see how 18ac1 does first
