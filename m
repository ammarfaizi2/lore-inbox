Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTKPSeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTKPSeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:34:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263064AbTKPSd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:33:59 -0500
Date: Sun, 16 Nov 2003 18:33:53 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Matthew Wilcox <willy@debian.org>, Will Dyson <will_dyson@pobox.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
Message-ID: <20031116183352.GS24159@parcelfarce.linux.theplanet.co.uk>
References: <1068970562.19499.11.camel@thalience> <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk> <20031116182007.GA14120@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116182007.GA14120@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 06:20:07PM +0000, Jamie Lokier wrote:
> Matthew Wilcox wrote:
> > On Sun, Nov 16, 2003 at 03:16:03AM -0500, Will Dyson wrote:
> > > +// associates an integer enumerator with a pattern string.
> > 
> > Please no C++ comments.
> 
> "//" comments have been in standard C since 1999.
> 
> For the sake of stylistic consistency by all means exclude them, but
> please don't call them C++ now that they are standard in C.

Good luck with that.  Note that syphilis kept the name of French disease
for many decades after it had become standard in all European countries,
even though it almost definitely did not originate in .fr in the first
place.
