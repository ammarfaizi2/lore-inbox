Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSLBWeZ>; Mon, 2 Dec 2002 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSLBWeZ>; Mon, 2 Dec 2002 17:34:25 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63506
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265126AbSLBWeZ>; Mon, 2 Dec 2002 17:34:25 -0500
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>, marcelo@connectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021202223800.A24773@infradead.org>
References: <20021202192652.A25938@sgi.com>
	 <1919608311.1038822649@[10.10.2.3]> <20021202201101.A26164@sgi.com>
	 <1038869248.8945.18.camel@irongate.swansea.linux.org.uk>
	 <20021202223800.A24773@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1038868912.869.60.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:41:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 17:38, Christoph Hellwig wrote:
> On Mon, Dec 02, 2002 at 10:47:28PM +0000, Alan Cox wrote:
> > > Ingo vetoed it.
> > 
> > I wasnt aware Ingo had a veto
> 
> It's not exactly considered nice to merge code against the intention
> of it's author.  (which doesn't mean it's impossible, of course)

Ingo did explicitly mention he thought the O(1) scheduler was not 2.4
material.  Whether this has changed, e.g. due to stabilization of the
scheduler, I do not know.  But I do recall he had an opinion in the
past.

	Robert Love

