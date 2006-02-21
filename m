Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161417AbWBUH7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbWBUH7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWBUH7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:59:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161417AbWBUH7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:59:53 -0500
Subject: Re: 2.6.16-rc4-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, reuben-lkml@reub.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060220165327.64f15bba.akpm@osdl.org>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	 <43F9B8A9.4000506@reub.net> <20060220201506.GU27946@ftp.linux.org.uk>
	 <20060220165327.64f15bba.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 08:59:48 +0100
Message-Id: <1140508788.3082.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 16:53 -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > It really would be more useful to pick individual branches
> >  	fixes.b8
> >  	m32r.b0
> >  	m68k.b8
> >  	xfs.b8
> >  	uml.b1
> >  	net.b6
> >  	frv.b8
> >  	misc.b8
> >  	upf.b5
> >  	volatile.b0
> >  	endian.b8
> >  	net-endian.b3
> 
> OK...  But it looks like these are liable to be removed, renamed or added
> to at the drop of a hat.  I don't know how to keep up with that.

maybe a for-akpm branch can be made?

