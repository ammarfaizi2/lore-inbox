Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRLLPth>; Wed, 12 Dec 2001 10:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLLPt2>; Wed, 12 Dec 2001 10:49:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280002AbRLLPtM>; Wed, 12 Dec 2001 10:49:12 -0500
Subject: Re: AACRAID & Kernel-2.4.17-pre8
To: csy@hjc.edu.sg (Chen Shiyuan)
Date: Wed, 12 Dec 2001 15:58:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1008169010.3c1770320ed43@home.hjc.edu.sg> from "Chen Shiyuan" at Dec 12, 2001 10:56:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EBmK-0001UU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dell PowerEdge 2550 with an AACRAID controller in place.
> 
> Does anyone know how to get rid of these messages or are they indicative 
> of some bugs in the system?

I left debugging on in error. I've sent Marcelo the diff to turn it back
off (top line of aacraid.h)
