Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSGKMsN>; Thu, 11 Jul 2002 08:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317832AbSGKMsM>; Thu, 11 Jul 2002 08:48:12 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:13068 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S317790AbSGKMsM> convert rfc822-to-8bit;
	Thu, 11 Jul 2002 08:48:12 -0400
Date: Thu, 11 Jul 2002 14:50:54 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Athlon + Athlon optimized kernel => _mmx_mmcpy problems
Message-ID: <Pine.LNX.4.44.0207111448450.3904-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I thought, as I have an Athlon, I should recompile my 2.4.18-ac3 kernel 
for Athlon optimzied ... yadda ... but this causes serious problems.

After booting, it has quite a lot of depmod problems, with depmod -e it 
shows all are '_mmx_mmcpy' and vmware can't compile, cause of the same 
error.

so I had to go back to PIII style ... or I wouldn't have been able to 
update vmware ... sad thing

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

