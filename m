Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSCOSuK>; Fri, 15 Mar 2002 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCOSuF>; Fri, 15 Mar 2002 13:50:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54542 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293129AbSCOSt4>; Fri, 15 Mar 2002 13:49:56 -0500
Subject: Re: amd nvidia and mem=nopentium
To: Nicolas.Turro@sophia.inria.fr (Nicolas Turro)
Date: Fri, 15 Mar 2002 19:05:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203151841.g2FIfRa09172@atlas.inria.fr> from "Nicolas Turro" at Mar 15, 2002 07:41:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lx1N-0004NZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, i have system dual athlon  XP 1900+ system and a nvidia graphic board :
> I need to use the mem=nopentium kernel parameter in order to run X without
> crashes. I'd like to know :
> 1- what are the consequences of  'mem=nopentium' ? Any performance loss ?

Yes. On the whole probably not a lot. You are running XP not MP processors
and the like so you are obviously not too worried about stability. You might
want to see if it actually does crash without nopentium.

> i intend to use a gigabit ethernet adapter on this box.
> 2- is there any fix going on that i should monitor ?

Some gige cards don't seem to work with some dual athlon bioses. Other than
that it should be fine
