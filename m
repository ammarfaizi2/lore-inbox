Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTEEOra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEEOrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:47:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59349 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262323AbTEEOq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:46:58 -0400
Date: Mon, 5 May 2003 14:59:20 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505145920.E23456@devserv.devel.redhat.com>
References: <20030505113330.B8615@devserv.devel.redhat.com> <Pine.LNX.4.44.0305051650270.1045-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305051650270.1045-100000@einstein31.homenet>; from tigran@veritas.com on Mon, May 05, 2003 at 04:53:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 5 May 2003, Arjan van de Ven wrote:
> 
> > On Mon, May 05, 2003 at 01:31:19PM +0200, Terje Eggestad wrote:
> > > In all fairness this should be done in glibc,
> > 
> > ... or a LD_PRELOAD library......
> 
> which doesn't work with statically linked binaries, does it?

good thing the LGPL on glibc requires a relinkable version to be offered
as well ;)
