Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbTGHJ0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266913AbTGHJ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:26:15 -0400
Received: from [217.113.73.39] ([217.113.73.39]:43099 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S266912AbTGHJ0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:26:14 -0400
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: "Peter C. Ndikuwera" <pndiku@dsmagic.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       smiler@lanil.mine.nu, KML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030708085558.GG15452@holomorphy.com>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	 <1057647818.5489.385.camel@workshop.saharacpt.lan>
	 <20030708072604.GF15452@holomorphy.com>
	 <200307081051.41683.schlicht@uni-mannheim.de>
	 <20030708085558.GG15452@holomorphy.com>
Content-Type: text/plain
Organization: Digital Solutions Ltd
Message-Id: <1057657046.1819.11.camel@mufasa.ds.co.ug>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 08 Jul 2003 12:37:26 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VMware patches are ...

ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-updateXX.tar.gz

Peter

On Tue, 2003-07-08 at 11:55, William Lee Irwin III wrote:
> On Tue, Jul 08, 2003 at 10:51:39AM +0200, Thomas Schlichter wrote:
> > Well, the NVIDIA patches are at
> >    http://www.minion.de/nvidia.html
> > but I don't know about the VMWARE patches...
> 
> Thanks. I'll grab that and start maintaining highpmd updates for it.
> 
> 
> On Tue, Jul 08, 2003 at 10:51:39AM +0200, Thomas Schlichter wrote:
> > Btw, what do you think about the idea of exporting the follow_pages()
> > function from mm/memory.c to kernel modules? So this could be used
> > for modules compiled for 2.[56] kernels and the old way just for 2.4
> > kernels...
> 
> I don't really have an opinion on it, but it's not my call.
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

