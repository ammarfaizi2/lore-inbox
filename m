Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJHXwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJHXwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:52:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:44727 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbTJHXwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:52:43 -0400
Date: Wed, 8 Oct 2003 16:52:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7-osdl1
Message-Id: <20031008165222.7866a3de.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/~shemminger/patches/2.6/2.6.0-test7/

Mostly same as 2.6.0-test6, just small changes to keep up with
underlying kernel changes.  One small new piece is scheduler stats.

o Ext3 extents				(Alex Tomas)
o ExecShield				(Ingo Molnar)
o Performance Counters (2.6.1)		(Mikael Pettersson)
o Linux Kernel Crash Dump		(Matt Robinson, et al)
o Kexec 				(Eric Biederman)
o RCU statistics               		(Dipankar Sarma)
o Scheduler statistics			(Rick Lindsley)

