Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUHEVhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUHEVhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267875AbUHEVfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:35:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48276 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267964AbUHEVdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:33:54 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Altix I/O code reorganization
Date: Thu, 5 Aug 2004 14:32:36 -0700
User-Agent: KMail/1.6.2
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20040805181619.GA30543@kroah.com> <Pine.SGI.3.96.1040805155001.143418D-100000@fsgi900.americas.sgi.com> <20040805210824.GA15962@kroah.com>
In-Reply-To: <20040805210824.GA15962@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051432.36240.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 5, 2004 2:08 pm, Greg KH wrote:
> On Thu, Aug 05, 2004 at 03:51:46PM -0500, Pat Gefre wrote:
> > On Thu, 5 Aug 2004, Greg KH wrote:
> >
> > + On Wed, Aug 04, 2004 at 03:14:08PM -0500, Pat Gefre wrote:
> > + >
> > + > The patches and a short comment for each:
> > +
> > + Care to post the patches here so that we can comment on them?
> > +
> > + greg k-h
> > +
> >
> > I thought I put the url where the patches are.
>
> You did.  You must not have read what Documentation/SubmittingPatches
> says to do...

Quoting said document:

  7) E-mail size.

  When sending patches to Linus, always follow step #6.

  Large changes are not appropriate for mailing lists, and some
  maintainers.  If your patch, uncompressed, exceeds 40 kB in size,
  it is preferred that you store your patch on an Internet-accessible
  server, and provide instead a URL (link) pointing to your patch.

A few of the patches at that URL are very large (one is over 400k).  That 
said, some of the others could probably be posted.

Jesse
