Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSLBWaq>; Mon, 2 Dec 2002 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLBWaq>; Mon, 2 Dec 2002 17:30:46 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:1551 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265097AbSLBWaq>; Mon, 2 Dec 2002 17:30:46 -0500
Date: Mon, 2 Dec 2002 22:38:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, marcelo@connectiva.com.br,
       rml@tech9.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021202223800.A24773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>, marcelo@connectiva.com.br,
	rml@tech9.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <20021202201101.A26164@sgi.com> <1038869248.8945.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1038869248.8945.18.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 02, 2002 at 10:47:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 10:47:28PM +0000, Alan Cox wrote:
> > Ingo vetoed it.
> 
> I wasnt aware Ingo had a veto

It's not exactly considered nice to merge code against the intention
of it's author.  (which doesn't mean it's impossible, of course)
