Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSDNXz6>; Sun, 14 Apr 2002 19:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312513AbSDNXz5>; Sun, 14 Apr 2002 19:55:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312511AbSDNXz4>; Sun, 14 Apr 2002 19:55:56 -0400
Subject: Re: Memory Leaking. Help!
To: ivan@es.usyd.edu.au (ivan)
Date: Mon, 15 Apr 2002 01:10:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204150848340.20787-100000@dipole.es.usyd.edu.au> from "ivan" at Apr 15, 2002 08:51:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wu4J-00057Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > totally mislead by it. Named for example will grow and shrink over time 
> > according to what it has cached and what people asked for.
> 
> But it took half of my swap (4GB) as well. A bit too much 
> for a little bind. How to explain this?

2Gb seems a bit odd - are you sure bind is the one that ate it ?

What does ps -aux imply has all the memory ?
