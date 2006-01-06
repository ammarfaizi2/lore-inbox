Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWAFGZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWAFGZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWAFGZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:25:47 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:53840 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932635AbWAFGZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:25:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J9Ne/ts1OXGb5lQPy3NtNmFE2bkxtrf7GOlgZhDsCudgPFeNuGbi6LLt93zDHcXSmYru52qPUYflWIffxd6ogNR1ofoGoBwAfWYOCyBx7xyyte4VSREcRIEHGRkNcMghmadb5JawP43LEXPqQI79c76CnVoWB0wR1Bb463FYkcU=
Message-ID: <25ac9de40601052225i48bca97dx3ad796a1cd68f1c3@mail.gmail.com>
Date: Fri, 6 Jan 2006 00:25:46 -0600
From: Patrick Read <pread99999@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops in Kernel 2.6.15 usbhid
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Oops in Kernel 2.6.15 usbhid

[2.] Compiled 2.6.15 downloaded from kernel.org.  Configured, made,
and installed.  During reboot, I get an Oops in the USB HID module. 
This does not occur with a nearly-identical config on the same
computer with kernel 2.6.14.5.

[3.] USB, HID, kernel, 2.6.15, module

[4.] 2.6.15

[5.] 2.6.14.5

[6.] Syslog available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/syslog-2.6.15-DEBUG.txt

[7.] N/A

[8.] N/A

[8.1] Output of ver_linux script available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/ver_linux_output.txt

[8.2] CPU information (/proc/cpuinfo) available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/cpuinfo-DEBUG.txt

[8.3] Module information (/proc/modules) available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/modulesinfo-DEBUG.txt

[8.4] Information regarding I/O Ports/Memory available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/ioports-DEBUG.txt and
http://www.cs.txstate.edu/~patrick/kernel-debug/iomem-DEBUG.txt

[8.5] PCI information available online at
http://www.cs.txstate.edu/~patrick/kernel-debug/lspci-vvv-as-root-DEBUG.txt

[8.6] SCSI devices:  None
patrick@pr01:~$ cat /proc/scsi/scsi
Attached devices:
patrick@pr01:~$

[8.7] Other information: None

[X.] I copied everything over to text files (plain ASCII) and posted
them online in the interest of saving space in this e-mail.  The
entire directory is browseable at
http://www.cs.txstate.edu/~patrick/kernel-debug/

Thank you,
Patrick A. Read
