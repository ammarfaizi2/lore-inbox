Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWBXJ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWBXJ5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWBXJ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:57:52 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:30025 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbWBXJ5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:57:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EsPboXQUFo5VP6oSPnlTScRSDOqeQTm0BuHiRZBnHxtbt3smFO0liNB225XKSN4yoOka/PnXIkNVASZ2NDVtcXFbVfcCMv46zp6maUEO6ZNmyYenR/9ng2FO5VKEFzMvQxxE4lXo6OGlfo3viKzagTaCqqJ/SU3nQDDXzqZekW4=
Message-ID: <f30adcc00602240157w7104c598qe7fffa2dcbee6105@mail.gmail.com>
Date: Fri, 24 Feb 2006 11:57:45 +0200
From: "aziro aziroff" <aziro.linux.adm@gmail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [JNI FCE-3210-C 32-bit PCI-to-Fibre Channel HBA]Driver for linux kernel 2.4 and/or 2.6?
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux Folk,
I looking for linux driver for one old JNI Fibre Channel (FC) host bus adapter
model: FCE-3210 "32-bit" PCI-to-Fibre Channel HBA (1999/2000).
I ask google and nothing about driver donload link, just comment and
broken links:)
http://www.exquip.com/products/storage/hostbusadapters.php?view=250

I read that Red Hat Linux 6.0, 6.1 support JNI FCE-3210, but no
information about kernels 2.4 and 2.6?!

>From manifacturer docs "Installation Guide for FCE-3210":

>Linux Drivers
>Follow the instructions appropriate for your system: single or dual processor.
>Single Processor Systems
>1. Install Linux and shutdown the system.
>2. Add the JNI HBAs and boot the system.
>3. Download the Linux driver jnifc.o file from the JNI Web site (www.jni.com).
>4. Copy the jnifc.o to any Linux directory.
>5. Run insmod jnifc.o then check the messages file /var/log/messages
for map drive
>information.
>Note – You must have a good link to storage or a loopback before
running the insmod >command;
>otherwise, the machine will hang.
>6. To mount the device, invoke a mount command.
>7. Before removing the JNI Linux driver, use a umount command to
un-mount the device.
>8. Type the command cat /proc/modules to show all loaded driver
modules, and run rmmod
>jnifc to remove the Linux driver.
>Dual Processor Systems
>1. Install Linux and shut down the system.
>2. Add the JNI HBAs and boot the system.
>3. Download the Linux driver jnifc_smp.o file from the JNI Web site
(www.jni.com).
>4. Copy the jnifc_smp.o to any Linux directory.
>5. Run insmod jnifc_smp.o then check the messages file
/var/log/messages for map drive
>information.
>Note – You must have a good link to storage or a loopback before
running the insmod >command;
>otherwise, the machine will hang.
>6. To mount the device, invoke a mount command.
>7. Before removing the JNI Linux driver, use a umount command to
un-mount the device
>8. Type the command cat /proc/modules to show all loaded driver
modules, and run rmmod
>jnifc_smp to remove the Linux driver.
>For more information
>See the readme file on the JNI Web site (www.jni.com) for the latest
information on driver
>configuration.

I ask JNI tech support, but they don't support Linux with this
FCE-3210 HBA yet. Support is for Solaris, AIX,HP-UX,Windows, but not
Linux!

Follk, if You can't help with driver for FCE-3210 kernel 2.4 and/or
2.6 nobody can!

Any help will be very welcome!

George
