Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVCPUiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVCPUiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVCPUiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:38:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:36764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262787AbVCPUiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:38:20 -0500
Date: Wed, 16 Mar 2005 12:38:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: bridge@osdl.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [ANNOUNCE] bridge utilities 1.0.6
Message-ID: <20050316123828.0eb78fd3@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor update to bridge utilities for 2.4/2.6. The changes are:
 + Better usage of autoconf to manage detecting sysfs library
 + Support multiple interfaces for add/delete interface commands.
	Example: brctl addif br0 eth0 eth1 eth2 
 - Remove code that was dead and no longer used

http://prdownloads.sourceforge.net/bridge/bridge-utils-1.0.6.tar.gz?download
