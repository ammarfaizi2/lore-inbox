Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRH1Abf>; Mon, 27 Aug 2001 20:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRH1AbZ>; Mon, 27 Aug 2001 20:31:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57099 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269971AbRH1AbS>; Mon, 27 Aug 2001 20:31:18 -0400
Subject: Re: VM: Bad swap entry 0044cb00
To: bunk@fs.tum.de (Adrian Bunk)
Date: Tue, 28 Aug 2001 01:31:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.33.0108280204430.13898-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Aug 28, 2001 02:07:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bWnC-00055q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I upgraded my kernel from 2.4.8ac10 to 2.4.9ac2 some hours ago and I found
> the following message in my syslog file (I've never seen something like
> this before):
> 
> Aug 27 22:40:46 r063144 kernel: VM: Bad swap entry 0044cb00
> What does this mean (my machine seems to run fine)?

It I suspect means that Rik still has work to do. 
