Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWBWATu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWBWATu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWBWATt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:19:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37045 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751001AbWBWATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:19:46 -0500
Subject: Re: PANIC: sata_sil on 2.6.16-rc4-ide1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B7FF9C61-95ED-4495-971F-D55AAAA2F0F5@bootc.net>
References: <B7FF9C61-95ED-4495-971F-D55AAAA2F0F5@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 00:24:01 +0000
Message-Id: <1140654241.8672.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-22 at 23:53 +0000, Chris Boot wrote:
> Hi all,
> 
> I upgraded from 2.6.16-rc2-ide2 to 2.6.16-rc4-ide1 and suffered the  
> panic pasted below. Needless to say this all worked fine with the  
> previous kernel (and some). I have two Seagate 250GB drives connected  
> to the controller (a PCI Adaptec 1205SA). I'm testing -ide so I don't  
> have the whole IDE layer just for my rarely used DVD-RW on my VIA PATA.

Do you see the same crash on 2.6.16-rc4 without the IDE diff ?

