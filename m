Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289045AbSANUoW>; Mon, 14 Jan 2002 15:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSANUnE>; Mon, 14 Jan 2002 15:43:04 -0500
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:26599 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S289043AbSANUmI>; Mon, 14 Jan 2002 15:42:08 -0500
Date: Mon, 14 Jan 2002 21:42:03 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: slowdown with new scheduler.
Message-ID: <20020114214203.A387@bazooka.saturnus.vein.hu>
In-Reply-To: <20020114124541.A32412@suse.de> <20020114172010.GA173@elfie.cavy.de> <20020114192925.GA4441@elfie.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114192925.GA4441@elfie.cavy.de>
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@enclavenet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 08:29:25PM +0100, Heinz Diehl wrote:
> On Mon Jan 14 2002, Heinz Diehl wrote:
> 
> > 2.4.18-pre3	 	    real    7m55.243s
> > 			    user    6m34.080s
> > 			    sys     0m27.610s
> > 
> > 2.4.18-pre+H7		    real    7m35.962s
> > 			    user    6m34.270s
> > 			    sys     0m27.700s
> > 
> > 2.4.18-pre3-ac2	    real    7m39.203s
> > 			    user    6m34.110s
> > 			    sys     0m28.740s
> > 
> 
> 2.4.18-pre3+H7+preempt-rml  real    6m58.983s
>  			    user    6m34.500s
>  			    sys     0m27.820s
> 
That sounds very good! But what about the VM code?
Is the VM in 2.4.18-pre3+H7 as good as in 2.4.18-pre2aa2?
