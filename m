Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292936AbSCFB0I>; Tue, 5 Mar 2002 20:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292901AbSCFBZ6>; Tue, 5 Mar 2002 20:25:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:268 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292966AbSCFBZr>; Tue, 5 Mar 2002 20:25:47 -0500
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 6 Mar 2002 01:40:16 +0000 (GMT)
Cc: aia21@cam.ac.uk (Anton Altaparmakov),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3C84BFA6.2000800@evision-ventures.com> from "Martin Dalecki" at Mar 05, 2002 01:52:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iQPg-00058v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But is a short time ago that IDE problems appeared in 2.4.18...

2.4.18 base doesn't have this code so that smells like manure to me.

Irrespective of the implementation you need the functionality. If you want
to say "hey this implementation sucks" - I agree in part. If you want to
remove it then its time for the big flashing "BOGUS" sign 

