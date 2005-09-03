Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbVICGOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbVICGOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbVICGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:14:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42212 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161158AbVICGOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:14:15 -0400
Subject: Re: GFS, what's remaining
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050903051841.GA13211@redhat.com>
References: <20050901104620.GA22482@redhat.com>
	 <20050901035939.435768f3.akpm@osdl.org>
	 <1125586158.15768.42.camel@localhost.localdomain>
	 <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 08:14:00 +0200
Message-Id: <1125728040.3223.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 13:18 +0800, David Teigland wrote:
> On Thu, Sep 01, 2005 at 01:21:04PM -0700, Andrew Morton wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> > > >   possibly gain (or vice versa)
> > > > 
> > > > - Relative merits of the two offerings
> > > 
> > > You missed the important one - people actively use it and have been for
> > > some years. Same reason with have NTFS, HPFS, and all the others. On
> > > that alone it makes sense to include.
> > 
> > Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> > the technical reasons for merging gfs[2], ocfs2, both or neither?
> > 
> > If one can be grown to encompass the capabilities of the other then we're
> > left with a bunch of legacy code and wasted effort.
> 
> GFS is an established fs, it's not going away, you'd be hard pressed to
> find a more widely used cluster fs on Linux.  GFS is about 10 years old
> and has been in use by customers in production environments for about 5
> years.

but you submitted GFS2 not GFS.


