Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266191AbSL1Jm0>; Sat, 28 Dec 2002 04:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSL1JmZ>; Sat, 28 Dec 2002 04:42:25 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:49412 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266173AbSL1JmY>; Sat, 28 Dec 2002 04:42:24 -0500
Date: Sat, 28 Dec 2002 09:50:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Samuel Flory <sflory@rackable.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228095027.A29971@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Samuel Flory <sflory@rackable.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Dec 28, 2002 at 03:32:44AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 03:32:44AM -0200, Marcelo Tosatti wrote:
> >     I've been using both drivers for some time with no issues.  Or maybe
> > you'd prefer Alan put it in his tree 1st?
> 
> Ho, hum, I prefer getting it tested in -ac for a while first.

Doesn't make much sense for aic79xx which is a new driver (= not changing
existing code at all) and already shipped by the commercial distros for ages..

