Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290553AbSBLRKt>; Tue, 12 Feb 2002 12:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290609AbSBLRKj>; Tue, 12 Feb 2002 12:10:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290553AbSBLRK2>; Tue, 12 Feb 2002 12:10:28 -0500
Subject: Re: nm256_audio.o
To: NyQuist@ntlworld.com (NyQuist)
Date: Tue, 12 Feb 2002 17:24:12 +0000 (GMT)
Cc: bruce@ask.ne.jp (Bruce Harada), linux-kernel@vger.kernel.org (Kernel)
In-Reply-To: <1013531519.9204.33.camel@stinky.pussy> from "NyQuist" at Feb 12, 2002 04:31:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16agf6-0002S2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Still not working, but thanks for the info anyway. Tried with 1,2 and a
> couple of megs down from the physical memory from meminfo, but still no
> dice. Afaik, i remember something about the memory of the graphics and
> audio being shared, and since X cuts in first, it gobbles the memory up.
> Not sure about that one as it still doesn't work if i run init3 and kill
> X. 

The Dell only works in 2.4.18pre7-ac3 or higher. Someone finally figured
out the problem and got me a fix. On other boxes its been fine for years
