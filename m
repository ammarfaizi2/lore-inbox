Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273013AbRIWVSZ>; Sun, 23 Sep 2001 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273012AbRIWVSP>; Sun, 23 Sep 2001 17:18:15 -0400
Received: from ns-3.dglnet.com.br ([200.246.42.67]:8065 "HELO
	ns-3.dglnet.com.br") by vger.kernel.org with SMTP
	id <S272983AbRIWVSJ>; Sun, 23 Sep 2001 17:18:09 -0400
Date: Sun, 23 Sep 2001 18:19:07 -0300
From: "Edson Y.Fugio" <edson@dglnet.com.br>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.10 **** AE_ERROR **** Invalid Reference Count (201) in object c18d3264
Message-Id: <20010923181907.55620090.edson@dglnet.com.br>
Organization: DGLNet - Campinas
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Intel SBT2 mainboard (2 PIII 866, 512MB), bios Release 1.11 Build 22
With 2.4.10 start to show this error:

Sep 23 17:12:21 smtp tbxface-0107 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Sep 23 17:12:21 smtp utdelete-0351 [12] Ut_update_ref_count   : **** AE_ERROR **** Invalid Reference Count (201) in object c1
8d3264
Sep 23 17:12:21 smtp 
Sep 23 17:12:21 smtp utdelete-0351 [12] Ut_update_ref_count   : **** AE_ERROR **** Invalid Reference Count (202) in object c1
8d3264
...

Sep 23 18:05:15 smtp 
Sep 23 18:05:15 smtp Parsing Methods:........................................................................................
.............................................................................................................................
...........................
Sep 23 18:05:15 smtp 240 Control Methods found and parsed (678 nodes total)
Sep 23 18:05:15 smtp ACPI Namespace successfully loaded at root c0332dc0
Sep 23 18:05:15 smtp ACPI: Core Subsystem version [20010831]
Sep 23 18:05:15 smtp evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Sep 23 18:05:15 smtp Executing device _INI methods:....................................................
Sep 23 18:05:15 smtp 52 Devices found: 52 _STA, 1 _INI
Sep 23 18:05:15 smtp Completing Region and Field initialization:..................
Sep 23 18:05:15 smtp 13/16 Regions, 5/5 Fields initialized (678 nodes total)
Sep 23 18:05:15 smtp ACPI: Subsystem enabled
Sep 23 18:05:15 smtp ACPI: System firmware supports S0 S1 S4 S5
Sep 23 18:05:15 smtp Processor[0]: C0 C1
Sep 23 18:05:15 smtp Processor[1]: C0 C1
Sep 23 18:05:15 smtp Power Button: found
Sep 23 18:05:15 smtp Sleep Button: found


-- 
Edson Fugio

