Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTIJMwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTIJMwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:52:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35210 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263026AbTIJMwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:52:08 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01f801c37783$9ead8960$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <01c601c3777f$97c92680$5aaf7450@wssupremo>
	 <20030910114414.B14352@devserv.devel.redhat.com>
	 <01f801c37783$9ead8960$5aaf7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063198250.32730.36.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 13:50:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 11:09, Luca Veraldi wrote:
> SMP is crying...
> But not so much, if the lock is not lasting much, is it right?
> 
> THIS IS NOT WHAT WE CALL A SHORT LOCK SECTION:

This is the difference between science and engineering. Its a path that
isnt normally taken and normally if taken takes almost no loops.


