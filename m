Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTGHIkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 04:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbTGHIkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 04:40:09 -0400
Received: from holomorphy.com ([66.224.33.161]:15009 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265531AbTGHIkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 04:40:06 -0400
Date: Tue, 8 Jul 2003 01:55:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       smiler@lanil.mine.nu, KML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030708085558.GG15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
	smiler@lanil.mine.nu, KML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <1057647818.5489.385.camel@workshop.saharacpt.lan> <20030708072604.GF15452@holomorphy.com> <200307081051.41683.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307081051.41683.schlicht@uni-mannheim.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 10:51:39AM +0200, Thomas Schlichter wrote:
> Well, the NVIDIA patches are at
>    http://www.minion.de/nvidia.html
> but I don't know about the VMWARE patches...

Thanks. I'll grab that and start maintaining highpmd updates for it.


On Tue, Jul 08, 2003 at 10:51:39AM +0200, Thomas Schlichter wrote:
> Btw, what do you think about the idea of exporting the follow_pages()
> function from mm/memory.c to kernel modules? So this could be used
> for modules compiled for 2.[56] kernels and the old way just for 2.4
> kernels...

I don't really have an opinion on it, but it's not my call.


-- wli
