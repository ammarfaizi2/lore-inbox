Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUBRU1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUBRU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:27:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:9190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268058AbUBRU1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:27:11 -0500
Date: Wed, 18 Feb 2004 12:26:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 + hp100 -> Oops
Message-Id: <20040218122601.56e47118@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040218201559.GA31872@bougret.hpl.hp.com>
References: <20040218201559.GA31872@bougret.hpl.hp.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 12:15:59 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 	Hi,
> 
> 	Maybe it would be a good idea to fix or revert the hp100 patch
> that went into 2.6.3 :

Modular or non-modular?  There seems to be a lot of debug stuff in the driver,
could you enable it and see where it hiccup'd.
