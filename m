Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTFZA0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTFZA0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:26:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265188AbTFZA0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:26:38 -0400
Date: Wed, 25 Jun 2003 17:40:48 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2..5.73-osdl2
Message-Id: <20030625174048.221471a0.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/shemminger/patches/patch-2.5.73-osdl2.bz2

No new content, just refreshing to keep up to date.

The purpose of these patches is to get more testing and exposure on
features that would be relevant to server systems running enterprise
applications like database servers.

Given the stabilty of 2.5, most of these patches are related to 
instrumentation and are most useful to the OSDL performance testing
groups needs.

Never sent out 2.5.73-osdl1 because it didn't boot on the STP
test machines (some old megaraid driver stuff that crept in).

Bug fixes:
o Allow kernel build without hotplug

Existing
o NUMA text replication			(Dave Hansen)
o Kexec 				(Eric Biederman, Andy Pfiffer)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
  includes relayfs
o Lockmeter
o Atomic 64 bit i_size access		(Daniel McNeil)
o Pentium Performance Counters		(Mikael Pettersson)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)

