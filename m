Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUBYS5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBYS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:56:37 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:53090 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261536AbUBYSxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:53:44 -0500
Date: Wed, 25 Feb 2004 20:55:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Timothy Miller <miller@techsource.com>,
       Rik van Riel <riel@redhat.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040225195515.GA2712@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Timothy Miller <miller@techsource.com>,
	Rik van Riel <riel@redhat.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>, Greg KH <greg@kroah.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Woodruff, Robert J" <woody@co.intel.com>,
	linux-kernel@vger.kernel.org, "Hefty, Sean" <sean.hefty@intel.com>,
	"Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
	"Davis, Arlin R" <arlin.r.davis@intel.com>,
	marcelo.tosatti@cyclades.com
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com> <403CCC77.6030405@techsource.com> <20040225185553.GA2474@mars.ravnborg.org> <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 10:05:32AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 25 Feb 2004, Sam Ravnborg wrote:
> > 
> > If we take the vendor persåective here. Then why should they make their
> > driver open source, when the middle layer is not part of the 
> > main stream kernel?
> 
> And why should we take the vendor perspective?

The people developing Inifiband support ask for a review.
And to me it looks too easy to say "no open source driver", so 
do not expect a review. Everything is voluntary of course.

Inclusion in the kernel is for me a different matter.

> We don't add drivers for stuff that doesn't exist, and is not even likely 
> to be used much. That way, when problems occur (and they _will_ occur), 
> the burden of the crap will be firmly on the shoulders of the people who 
> should care.

Yep, agree on that - but does not conflict when what I meant to say.

	Sam
