Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTIVOLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbTIVOLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:11:05 -0400
Received: from dagobah.vivo.com.br ([200.244.85.31]:15240 "EHLO
	rjlngtw02.vivo.com.br") by vger.kernel.org with ESMTP
	id S263151AbTIVOLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:11:03 -0400
Subject: RE: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
To: jun.nakajima@intel.com
Cc: pawel.dziekonski@pwr.wroc.pl, linux-kernel@vger.kernel.org,
       jcastro@vialink.com.br
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF33F914A6.53F3FBCC-ON03256DA9.004C95C9@vivo.com.br>
From: juan.carlos@vivo.com.br
Date: Mon, 22 Sep 2003 12:09:42 -0200
X-MIMETrack: Serialize by Router on RJLNGTW02/Celular(Release 5.0.11  |July 24, 2002) at
 09/22/2003 11:11:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I tried the patch you wrote (and noticed it is now in 2.4.22-ac3)
but I still have the same hard lockup Pawel Dziekonski has -- and, like
him, everything works when I don't compile ACPI into the kernel. My mobo is
a Soyo K7VTA-PRO, Athlon 950 Mhz, chipset VIA82Csomething.

Is there a piece of information I could send you that would help (BIOS
settings, /proc listings)? Please CC to me at j[CUBAN-DICTATOR'S-SURNAME]
@vialink.com.br, I'm not subscribed to LKML (but could be since I'm getting
broadband today. Yay!) :)

Cheers all,

Juan Carlos Castro y Castro
VIVO - Diretoria de Processos de Negócio - Projetos
Tel.: 55 (21) 2574-3506 - Cel.: 55 (21) 9603-7440
juan.carlos@vivo.com.br
jcastro@vialink.com.br





