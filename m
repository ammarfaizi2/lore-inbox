Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136756AbRAHElb>; Sun, 7 Jan 2001 23:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136800AbRAHElW>; Sun, 7 Jan 2001 23:41:22 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:59908 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S136756AbRAHElI>;
	Sun, 7 Jan 2001 23:41:08 -0500
Date: Mon, 8 Jan 2001 05:40:52 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: Rafal Maszkowski <rzm@icm.edu.pl>
Cc: lizzi@cnam.fr, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.0: not loading fore200e
Message-ID: <20010108054052.A13378@burza.icm.edu.pl>
In-Reply-To: <20010108025656.A4450@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
In-Reply-To: <20010108025656.A4450@burza.icm.edu.pl>; from rzm@icm.edu.pl on Mon, Jan 08, 2001 at 02:56:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 02:56:56AM +0100, Rafal Maszkowski wrote:
> Pure 2.4.0 on sparc32 with RedHat 6.2:
> root@etest:/usr/src/6,0# modprobe fore200e
> /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: couldn't find the kernel version the module was compiled for
> /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: insmod /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o failed
> /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: insmod fore200e failed

Linking error, Makefile was fixed by 2.4.0-ac2.

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
