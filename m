Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTKPSVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTKPSVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:21:48 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:58549 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263119AbTKPSVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:21:46 -0500
Date: Sun, 16 Nov 2003 18:20:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Will Dyson <will_dyson@pobox.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
Message-ID: <20031116182007.GA14120@mail.shareable.org>
References: <1068970562.19499.11.camel@thalience> <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sun, Nov 16, 2003 at 03:16:03AM -0500, Will Dyson wrote:
> > +// associates an integer enumerator with a pattern string.
> 
> Please no C++ comments.

"//" comments have been in standard C since 1999.

For the sake of stylistic consistency by all means exclude them, but
please don't call them C++ now that they are standard in C.

Thanks :)

-- Jamie
