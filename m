Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVAGPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVAGPeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVAGPeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:34:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261458AbVAGPeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:34:17 -0500
Date: Fri, 7 Jan 2005 16:33:30 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107153328.GD28466@devserv.devel.redhat.com>
References: <20050107144223.GA28466@devserv.devel.redhat.com> <200501071527.j07FRXrD018499@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071527.j07FRXrD018499@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jan 07, 2005 at 10:27:33AM -0500, Paul Davis wrote:
> >now try 2.6.9 ;)
> >this deficiency got already fixed
> 
> well thats good, i hope someone updated the man page too :) 
> 
> but is there actually any way to grant specific users a reasonable
> rlimit, 

yes; most distributions will use pam for this, you can set per user or per
gorup limits there.
