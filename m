Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFZSdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFZSdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:33:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262312AbTFZSdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:33:17 -0400
Date: Thu, 26 Jun 2003 11:47:30 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.73-osdl3
Message-Id: <20030626114730.1dd4e490.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/shemminger/patches/patch-2.5.73-osdl3.bz2

Updated to latest version:
o Pentium Performance Counters		(Mikael Pettersson)

Bug fixes:
o Allow kernel build without hotplug

New
o NUMA text replication			(Dave Hansen)
o Kexec 				(Eric Biederman, Andy Pfiffer)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
  includes relayfs
o Lockmeter				(John Hawkes)
o Atomic 64 bit i_size access		(Daniel McNeil)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)

