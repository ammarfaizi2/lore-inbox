Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWIYPYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWIYPYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWIYPYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:24:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37792 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750969AbWIYPYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:24:36 -0400
Subject: Re: [PATCH -mm updated] PCMCIA: Add few IDs into ide-cs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, linux-pcmcia@lists.infradead.org
In-Reply-To: <200609251659.44848.openembedded@hrw.one.pl>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <200609251659.44848.openembedded@hrw.one.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 25 Sep 2006 16:48:04 +0100
Message-Id: <1159199284.11049.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 16:59 +0200, ysgrifennodd Marcin Juszkiewicz:
> Dnia środa, 20 września 2006 22:54, Andrew Morton napisał:
> 
> > When replying to this email, please rewrite the Subject: to something
> > appropriate.  Please also attempt to cc the appropriate developer(s).
> 
> > pcmcia-add-few-ids-into-ide-cs.patch
> 
> I got another submission from user so had to update patch.
> 
> From: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Acked-by: Alan Cox <alan@redhat.com>

Same update needs to go into drivers/ata/pata_pcmcia

Alan

