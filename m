Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272899AbTG3ODq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272901AbTG3ODq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:03:46 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:61684 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272894AbTG3ODp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:03:45 -0400
Subject: Re: Linux 2.4.22-pre9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20030730080726.00a797e0@pop.t-online.de>
References: <5.1.0.14.2.20030730080726.00a797e0@pop.t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059573029.8051.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 14:58:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 07:08, Margit Schubert-While wrote:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre9; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.22-pre9/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
> 
> Still not fixed :-)

You still haven't sent a patch to fix it 8)

