Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUHZMum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUHZMum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHZMrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:47:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14090 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268919AbUHZMo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:44:29 -0400
Date: Thu, 26 Aug 2004 13:44:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olivier Galibert <galibert@pobox.com>,
       Christoph Hellwig <hch@infradead.org>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826134415.A19244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olivier Galibert <galibert@pobox.com>,
	Christian Mayrhuber <christian.mayrhuber@gmx.net>,
	reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk> <200408261245.47734.christian.mayrhuber@gmx.net> <20040826115229.A18013@infradead.org> <20040826124334.GA39176@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040826124334.GA39176@dspnet.fr.eu.org>; from galibert@pobox.com on Thu, Aug 26, 2004 at 02:43:34PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:43:34PM +0200, Olivier Galibert wrote:
> On Thu, Aug 26, 2004 at 11:52:29AM +0100, Christoph Hellwig wrote:
> > Sure, no one stops you from playing around with new semantics.  But please
> > don't add them to the linux kernel stable series until we have semantics we
> > a) want to stick to for a while and b) actually work.
> 
> He's not proposing to add it to 2.4, is he?

We're talking about 2.6 here.  2.4 is the obsolete kernel series these days.

