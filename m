Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRGGUjF>; Sat, 7 Jul 2001 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266539AbRGGUiz>; Sat, 7 Jul 2001 16:38:55 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:64523 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S266536AbRGGUit>; Sat, 7 Jul 2001 16:38:49 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Machine check exception? (2.4.6+SMP+VIA)
Date: Sat, 7 Jul 2001 13:32:21 -0700
Message-ID: <HDEBKHLDKIDOBMHPKDDKEEAIEMAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was running 2.4.6-stable in SMP mode on a dual P3-1GHz machine (VIA 694D
Chipset / MSI-6321 M/B + ) and the following message popped up after which
the system hardlocked (no SysRQ input).  What does this message mean?

CPU 1: Machine Check Exception: 0000000000000004
Bank 1: b200000000000115
Kernel panic: CPU context corrupt

Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
delta kernel: CPU 1: Machine Check Exception: 0000000000000004

Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
delta kernel: Bank 1: b200000000000115

Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
delta kernel: Kernel panic: CPU context corrupt

--
Vibol Hou

