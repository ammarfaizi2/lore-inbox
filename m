Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTKUQCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 11:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTKUQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 11:02:33 -0500
Received: from imap.gmx.net ([213.165.64.20]:19930 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263809AbTKUQCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 11:02:31 -0500
Date: Fri, 21 Nov 2003 17:02:30 +0100 (MET)
From: "Xyan" <xy.x@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: PROBLEM: no scancode, multimedia keys, microsoft natural, kernel 2.6
X-Priority: 5 (Lowest)
X-Authenticated: #5322896
Message-ID: <21814.1069430550@www56.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
1.  
	no scancode from "microsoft natural" keyboard using "showkeys -s" 
2. 
	in compare to kernel 2.4.22(where the keys function) i get no scancodes
when i 
press some multimedia  
	keys on my "microsoft natural" connected via PS/2. 
	i dont know is this a known bug/problem and whether i should report more or
 
	which informations.  
	a.	is this a known bug forget this mail.  
	b.	is this the wrong list to post please forward to the right one. 
3. 
	keyboard, multimedia keys, scancode, microsoft natural 
4.  
	Linux version 2.6.0-test9 (root@XYX-Xyan) (gcc version 3.3.1) #1 Thu Nov 20

08:07:20 UTC 2003 
	and 2.6.0-test9-bk25 
 
7.  
	linux LfS 5.0 
7.2  
	processor       : 0		vendor_id       : GenuineIntel 
	cpu family      : 6		model           : 8 
	model name      : Pentium III (Coppermine) 
	stepping        : 6		cpu MHz         : 933.859 
	cache size      : 256 KB	fdiv_bug        : no 
	hlt_bug         : no		f00f_bug        : no 
	coma_bug        : no		fpu             : yes 
	fpu_exception   : yes		cpuid level     : 2 
	wp              : yes 
	flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat 
pse36 mmx fxsr sse 
	bogomips        : 1826.81 
 
7.4 
	0000-001f : dma1	0020-0021 : pic1	0040-005f : timer 
	0060-006f : keyboard	0070-0077 : rtc		0080-008f : dma page reg 
	00a0-00a1 : pic2	00c0-00df : dma2	00f0-00ff : fpu 
	0170-0177 : ide1	01f0-01f7 : ide0	0376-0376 : ide1 
	03c0-03df : vga+	03f6-03f6 : ide0	0cf8-0cff : PCI conf1 
	4000-40ff : 0000:00:07.4 5000-500f : 0000:00:07.4 5000-5007 : viapro-smbus 
	6000-607f : 0000:00:07.4 c000-c00f : 0000:00:07.1 c000-c007 : ide0 
	c008-c00f : ide1	c400-c41f : 0000:00:07.2 c400-c41f : uhci_hcd 
	c800-c81f : 0000:00:07.3 c800-c81f : uhci_hcd	cc00-ccff : 0000:00:07.5 
	cc00-ccff : VIA686A	d000-d003 : 0000:00:07.5 d400-d403 : 0000:00:07.5 
	d400-d401 : VIA82xx MPU401 dc00-dcff : 0000:00:08.0 dc00-dcff : 8139too 
	e000-e0ff : 0000:00:0b.0 e000-e0ff : 8139too 
7.7	 
	a. microsoft natural via PS/2 german layout 
	 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

