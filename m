Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTAQMfn>; Fri, 17 Jan 2003 07:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTAQMfn>; Fri, 17 Jan 2003 07:35:43 -0500
Received: from mail.ilk.de ([194.121.104.8]:21005 "EHLO mail.ilk.de")
	by vger.kernel.org with ESMTP id <S267131AbTAQMfm> convert rfc822-to-8bit;
	Fri, 17 Jan 2003 07:35:42 -0500
Message-ID: <1F6206BC53BCD3119059009027D1D3A2058AA0B1@OEKAEX01.becker.de>
From: "Jurzitza, Dieter" <JurzitzaD@becker.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Question about boot-message
Date: Fri, 17 Jan 2003 13:38:03 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear listmembers,
I upgraded the boot-kernel on my Ultra SPARC 60 SMP (2x360) MHz. I get the
following messages at bootup I do not understand and would 
appreciate if someone could give me a comment:

Jan 15 00:16:19 oekalux08 kernel: klogd 1.4.1, ---------- state change
---------- 
Jan 15 00:16:19 oekalux08 kernel: Inspecting 
/boot/System.map-2.4.20-SMP
Jan 15 00:16:20 oekalux08 kernel: Loaded 12988 symbols from
/boot/System.map-2.4.20-SMP.
Jan 15 00:16:20 oekalux08 kernel: Symbols match kernel version 2.4.20.
Jan 15 00:16:20 oekalux08 kernel: Error reading kernel 
symbols - Cannot
allocate memory 

The map-file is found, it is parsed - but then the system says "Error
reading kernel symbols" The System.map-2.4.20-SMP - file is 
exactly the
one I got from the build-process. The kernel is vanilla-2.4.20.

Any suggestions are highly appreciated!
Take care


Dieter Jurzitza


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
         ESI

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: JurzitzaD@Becker.de
Internet: http://www.becker.de


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorised copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

