Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWHUUlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHUUlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWHUUlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:41:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbWHUUlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:41:17 -0400
Date: Mon, 21 Aug 2006 13:40:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       David Miller <davem@davemloft.net>,
       Linas Vepstas <linas@austin.ibm.com>, Jonathan Corbet <corbet@lwn.net>
Subject: NAPI documentation
Message-ID: <20060821134053.7225987b@dxpl.pdx.osdl.net>
In-Reply-To: <200608201948.20596.arnd@arndb.de>
References: <20060818220700.GG26889@austin.ibm.com>
	<44E7BB7F.7030204@osdl.org>
	<200608191325.19557.arnd@arndb.de>
	<200608201948.20596.arnd@arndb.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took this opportunity to get a start on improving NAPI documentation.
I mashed together the short text about NAPI (with permission) from lwn.net
and the existing NAPI-HOWTO, to make a page on the Linux net wiki.

I took the liberty of removing some of the bits that were out of date, or referred
to old Becker code. It still needs lots of editing to be presentable.

Please edit and improve
	http://linux-net.osdl.org/index.php/NAPI

When the page is in good shape, I will de-wiki it to place in kernel doc tree.
