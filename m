Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272168AbTG2XHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272169AbTG2XHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:07:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:32974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272168AbTG2XHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:07:21 -0400
Date: Tue, 29 Jul 2003 16:07:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-osdl1
Message-Id: <20030729160719.20e17f3b.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  http://developer.osdl.org/~shemminger/patches/patch-2.6.0-test2-osdl1.bz2
  PLM http://www.osdl.org/cgi-bin/getpatch?id=2023

Added some new patches (from -mm) that relate to large machines.

o Support for >32 cpu's			(Bill Irwin)
	- had to fix perfctr to handle this
o 64 bit device number's		(Andries Brower)

Older patches included:
o Relayfs				(Tom Zanussi)
o Performance Counters			(Mikael Pettersson)
o NUMA text replication			(Dave Hansen)
o Kexec 				(Eric Biederman, Andy Pfiffer)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
o Lockmeter				(John Hawkes)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)



