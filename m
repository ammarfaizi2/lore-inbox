Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbTJIWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbTJIWxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:53:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:42112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262648AbTJIWxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:53:22 -0400
Date: Thu, 9 Oct 2003 15:53:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.0-test7-netx1
Message-Id: <20031009155302.4f2fe835.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://developer.osdl.org/shemminger/netx/2.6/2.6.0-test7/2.6.0-test7-netx1/

This is the first of a hopefuly continuing series of network related experimental 
kernels.  This patch set will contain things like new network drivers, protocols 
and infrastructure changes that are not related to the stability goal
for the mainline kernel tree.

The initial installment includes:
    * ISA device probing changes
    * SimTel 4200 IRDA dongle (originally by Paul Stewart)
    * IRDA hashbin cleanup
    * WAN device bugfixes and cleanups
    * TCP Vegas (from Dave Miller)

I am interested in receiving patches for network related stuff
like:
    * drivers for new hardware
    * rework of old drives (will put in new e100 driver next time).
    * TCP tuning options
    * support for 1000's of network devices
    * network async i/o
    * per cpu network statistics




    
