Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSCXSGk>; Sun, 24 Mar 2002 13:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSCXSGW>; Sun, 24 Mar 2002 13:06:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311687AbSCXSGF>; Sun, 24 Mar 2002 13:06:05 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sun, 24 Mar 2002 18:22:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C9E0BBC.4030406@freenet.de> from "Andreas Hartmann" at Mar 24, 2002 06:24:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pCdY-0006tY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At the point you hit OOM every possible heuristic is simply handwaving that
> > will work for a subset of the user base. Fix the real problem and it goes
> > away.
> 
> On the other hand - nobody is perfect and there can be such situations. 

My system cannot (short of a bug) go OOM. Thats what the new overcommit
mode 2/3 ensures
