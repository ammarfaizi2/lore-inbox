Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRIHUGk>; Sat, 8 Sep 2001 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRIHUGb>; Sat, 8 Sep 2001 16:06:31 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:33801 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269786AbRIHUGQ>; Sat, 8 Sep 2001 16:06:16 -0400
Message-ID: <3B9A7A08.9AF4D0E5@t-online.de>
Date: Sat, 08 Sep 2001 22:05:28 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: MPS 1.1 against MPS 1.4 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I just noticed that i can inside my BIOS switch from MPS (Multi
Processor Specification ?) 1.1 to 1.4, the later is noticed as "for
future use", but when i enable it, the kernel says in dmesg that he
found a MPS 1.4...so it seems to work, at least it claims to.

Question:
Whats the difference between MPS 1.1 and 1.4 from Kernel-sight, the
system (ASUS P2B-DS, now Dual PIII/850/100 and 2.4.3, RH7.1) ran 2 years
with MPS 1.1 and PIII/450/100-CPUs on Kernel 2.2.12, so i see no need to
flip this switch and go to MPS 1.4...or does it make sense with the
2.4.x Kernels now ?

Interesting is that with MPS 1.1 the Kernel puts three devices (aic7xxx,
usb-uhci and eth0) on IRQ 10, with MPS 1.4 it puts the same three
devices on IRQ 19...so there seems to be difference.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
