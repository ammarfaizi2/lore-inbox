Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSF0QDF>; Thu, 27 Jun 2002 12:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSF0QDE>; Thu, 27 Jun 2002 12:03:04 -0400
Received: from [62.70.58.70] ([62.70.58.70]:64899 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316822AbSF0QDE> convert rfc822-to-8bit;
	Thu, 27 Jun 2002 12:03:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Can't find watchdog timer (sc1200)
Date: Thu, 27 Jun 2002 18:03:11 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206271803.11350.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can't make linux (2.4.19-rc1) detect the watchdog timer in the sc1200. Any 
ideas? 

Should this one show up in /proc/pci?

output from cpuinfo is below

thanks

roy


[root@localhost linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : Geode by NSC
cpu family      : 5
model           : 9
model name      : Unknown
stepping        : 1
cpu MHz         : 266.651
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 530.84

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

