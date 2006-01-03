Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWACRbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWACRbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWACRbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:31:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:41375 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932463AbWACRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:31:03 -0500
Subject: Re: [git patches] 2.6.x libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
References: <20060103164319.GA402@havoc.gtf.org>
	 <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 17:32:35 +0000
Message-Id: <1136309555.22598.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-03 at 17:51 +0100, Bartlomiej Zolnierkiewicz wrote:
> > + * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
> > + * for the early chip drivers.
> 
> pata_oldpiix and pata_mpiix are not in the mainline

They are probably ready for mainline and since Linux currently has no
support for either it might be nice to get them in. Anything specific
they need polishing for Jeff ?

Alan

