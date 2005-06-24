Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbVFXKrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbVFXKrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVFXKrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:47:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30903 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263239AbVFXKpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:45:47 -0400
Subject: Re: reiser4 plugins
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BB5E1A.70903@namesys.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <42BB31E9.50805@slaphack.com>
	 <1119570225.18655.75.camel@localhost.localdomain>
	 <42BB5E1A.70903@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119609680.17066.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Jun 2005 11:41:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-24 at 02:12, Hans Reiser wrote:
> >In which case the features belong in the VFS as all those with
> >experience and kernel contributions have been arguing.
> So you fundamentally reject the prototype it in one fs and then abstract
> it to others development model?

More fundamentally - prototype things *out* of the main kernel. If
everyone was doing their prototyping in kernel Andrew Morton would by
now be a team of about 25

Alan

