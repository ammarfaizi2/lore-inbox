Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUBZU4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUBZU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:56:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:11222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbUBZU4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:56:05 -0500
Date: Thu, 26 Feb 2004 12:55:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: Bunch of janitor IrDA patches
Message-Id: <20040226125510.1891185b@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040226204554.GA17458@bougret.hpl.hp.com>
References: <20040226031054.GA32263@bougret.hpl.hp.com>
	<20040226123519.76d4535b.davem@redhat.com>
	<20040226204554.GA17458@bougret.hpl.hp.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is more coming... Next set moves all the EXPORT_SYMBOL out of irsyms.c
Sort of a repeat of the ksyms.c change to the main kernel.
But will let stuff settle first, ie wait for next cycle.
