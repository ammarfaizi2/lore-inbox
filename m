Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290508AbSBFNdc>; Wed, 6 Feb 2002 08:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSBFNdW>; Wed, 6 Feb 2002 08:33:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290508AbSBFNdS>; Wed, 6 Feb 2002 08:33:18 -0500
Subject: Re: kernel: ldt allocation failed
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 6 Feb 2002 13:42:56 +0000 (GMT)
Cc: aia21@cam.ac.uk (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Feb 06, 2002 02:58:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YSLg-00056Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am ignorant on the subject, but why LDT is used in Linux at all?
> LDT register can be set to 0, this can speed up task switch time and save 
> some memory used for LDT.

Wine and certain threaded applications
