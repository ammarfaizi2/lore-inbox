Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313555AbSDYX6Q>; Thu, 25 Apr 2002 19:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313556AbSDYX6P>; Thu, 25 Apr 2002 19:58:15 -0400
Received: from slide.SoftHome.net ([66.54.152.30]:31113 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S313555AbSDYX6O>;
	Thu, 25 Apr 2002 19:58:14 -0400
From: dmacbanay@softhome.net
To: linux-kernel@vger.kernel.org
Subject: kernel 2.5.10 problems
Date: Thu, 25 Apr 2002 17:58:14 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.251.165.1]
Message-ID: <courier.3CC89816.00006EFA@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first time I've posted to this forum.  Usually when I have a 
problem with a kernel other people are having the same problem and it gets 
fixed relatively quickly.  But I've been experiencing some problems that 
haven't been going away.  If more information is needed then what I have 
given here please let me know.  I am using a SOYO K7VTA-B with a VIA 82C686B 
chipset and a Duron 750mhz processor. 

1.  Cannot mount IDE-SCSI cd drive.  This problem has been mentioned 
previously by others.  Errors occur when trying to mount it. 

2.  When ACPI support is installed the kernel gives a "Keyboard not found" 
error when booting and I have to push the reset switch to reboot.  This 
problem has also been mentioned before but I don't think anyone has related 
it to the ACPI support. 

3.  Starting sometime after kernel 2.5.1 (I couldn't compile any kernels 
from then up until 2.5.5) the Evolution email program locks up whenever 
Calender, Tasks, or Contacts is selected.  I have to go to another terminal 
and kill it. 

4.  Starting with kernel 2.5.6 (kernels 2.5.5 through 2.5.6-pre3 work)  the 
KDE program krecord closes right after it starts. 

5.  With the new ALSA routines built-in is it possible to get the midi 
output port on a Soundblaster PCI 512 to work?  I haven't been able to get 
it to function yet. 

Thank you in advance for your help 

David Macbanay 
