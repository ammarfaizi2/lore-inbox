Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbTCILjZ>; Sun, 9 Mar 2003 06:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbTCILjZ>; Sun, 9 Mar 2003 06:39:25 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:54335 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S262495AbTCILjY>; Sun, 9 Mar 2003 06:39:24 -0500
Subject: PROBLEM
From: =?ISO-8859-1?Q?K=F3sa?= Ferenc <fkosa@eposta.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-2
Organization: 
Message-Id: <1047210594.13821.37.camel@daisy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Mar 2003 12:49:55 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Newer kernels do not boot on 386

2. I use linux successfully since 1997. A year ago I've tried to use
linux on an AMD 5x86, and I realized that newer kernels (>2.4.13) do not
boot. It starts: "loading linux........" and then after a while it
reboots the computer, before "Ok, booting the kernel". I found the same
problem on a Cyrix 486SLC2 too. I tried compile kernels by myself, but
they did the same too, except for 2.4.13. The official Debian
kernel-images failed too. I use lilo-2.2, with debian 3.0 stable
(woody).

3. Kernel 
4. Kernel version: >  2.4.13
5. No Oops..
6.  No shell script
7. AMD 5x86, Cyrix 486SLC2 -  4MB RAM 800MB ide hd, 200MB swap, no PCI,
no SCSI, 2 isa eexpress network adapters, 1 serial, 1 parallel ports,
lilo-2.2. boot loader, debian 3.0 stable woody linux
 
thanks for helping, regards

-- 
Kósa Ferenc <fkosa@eposta.hu>

