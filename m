Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUHTQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUHTQKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUHTQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:10:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268292AbUHTQKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:10:39 -0400
Date: Fri, 20 Aug 2004 12:10:18 -0400
From: Alan Cox <alan@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>, y@redhat.com
Cc: Rik van Riel <riel@redhat.com>, Alan Cox <alan@redhat.com>,
       Oliver Neukum <oliver@neukum.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       greg@kroah.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-ID: <20040820161018.GA2340@devserv.devel.redhat.com>
References: <20040820150257.GC6812@devserv.devel.redhat.com> <Pine.LNX.4.44.0408201204300.10373-100000@dhcp83-102.boston.redhat.com> <20040820160605.GH19489@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820160605.GH19489@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 06:06:05PM +0200, Arjan van de Ven wrote:
> > > Are any of the VM guys considering PF_LOGALLOC so you can trace it down 8)
> > No, but this thread does make me consider PF_NOIO ;)
> given that the task of this thread is to DO io ... ;)

But not to cause I/O.. what are the semantics of PF_NOIO ?

