Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWGUK6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWGUK6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWGUK6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:58:42 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:5786 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750942AbWGUK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:58:41 -0400
Message-ID: <44C0B29F.2080604@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 12:55:27 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Panagiotis Issaris <takis@gna.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to	k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>  <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> Yeah, that's what Andrew prefers but there are maintainers that disagree 
> with that.

Then they should change CodingStyle.
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
