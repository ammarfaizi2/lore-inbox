Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSHKJmc>; Sun, 11 Aug 2002 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSHKJmc>; Sun, 11 Aug 2002 05:42:32 -0400
Received: from codepoet.org ([166.70.99.138]:61405 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318100AbSHKJmb>;
	Sun, 11 Aug 2002 05:42:31 -0400
Date: Sun, 11 Aug 2002 03:46:19 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020811094619.GB18298@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva> <20020811085717.GA17738@codepoet.org> <20020811101617.A2215@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811101617.A2215@infradead.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 11, 2002 at 10:16:17AM +0100, Christoph Hellwig wrote:
> On Sun, Aug 11, 2002 at 02:57:17AM -0600, Erik Andersen wrote:
> > > 	[PATCH] namespace.c - compiler warning
> > 
> > This patch is wrong....
> 
> Why?

I guess it would be more clear if I had said that namespace.c
in 2.4.20-pre1 was broken my the above mentioned patch, and
my patch fixes the problem...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
