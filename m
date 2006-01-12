Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWALVK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWALVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWALVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:10:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161279AbWALVK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:10:28 -0500
Date: Thu, 12 Jan 2006 13:10:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk98lin
Message-ID: <20060112131019.485edc65@dxpl.pdx.osdl.net>
In-Reply-To: <20060112204844.1BDCDC8C4@mx.dtiltas.lt>
References: <20060112180048.8A18EBC32@mx.dtiltas.lt>
	<20060112101843.0b0e159f@dxpl.pdx.osdl.net>
	<20060112204844.1BDCDC8C4@mx.dtiltas.lt>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 22:43:44 +0200
Nerijus Baliunas <nerijus@users.sourceforge.net> wrote:

> On Thu, 12 Jan 2006 10:18:43 -0800 Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > While developing the skge and sky2 driver I discovered more problems and
> > those got fixed in the mainline sk98lin driver.
> 
> What is a difference between them? Which one supports Marvell Technology
> Group Ltd. 88E8050 Gigabit Ethernet Controller (rev 17)?
> skge in 2.6.14 does not support it.

sky2 is for 88e8050 and related chips

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
