Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTGJW5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbTGJW5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:57:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269676AbTGJW46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:56:58 -0400
Date: Thu, 10 Jul 2003 16:11:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75-osdl1
Message-Id: <20030710161138.1a93d8f3.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  http://developer.osdl.org/~shemminger/patches/patch-2.5.75-osdl1.bz2

No new content, just bugfixing and refreshing to keep up to date.

The purpose of these patches is to get more testing and exposure on
features that would be relevant to server systems running enterprise
applications like database servers.


Contents:

o NUMA text replication			(Dave Hansen)
o Kexec 				(Eric Biederman, Andy Pfiffer)
  - bugfix for machines with lots of memory
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
  includes relayfs
o Lockmeter				(John Hawkes)
o Atomic 64 bit i_size access		(Daniel McNeil)
o Pentium Performance Counters		(Mikael Pettersson)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)

