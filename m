Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUBYRyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUBYRyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:54:40 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:53537 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261489AbUBYRyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:54:24 -0500
Date: Wed, 25 Feb 2004 19:55:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Timothy Miller <miller@techsource.com>
Cc: Rik van Riel <riel@redhat.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040225185553.GA2474@mars.ravnborg.org>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Rik van Riel <riel@redhat.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>, Greg KH <greg@kroah.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Woodruff, Robert J" <woody@co.intel.com>,
	linux-kernel@vger.kernel.org, "Hefty, Sean" <sean.hefty@intel.com>,
	"Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
	"Davis, Arlin R" <arlin.r.davis@intel.com>,
	marcelo.tosatti@cyclades.com, torvalds@osdl.org
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com> <403CCC77.6030405@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <403CCC77.6030405@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >I'm sure infinibad will be inetresting once htere are
> >actual hardware driver.s  However, I'm not aware of any
> >open source drivers in existnace now, so what good is
> >a stack ?
> >
> 
> Chicken and egg.  If infiniband has some significant value, it would be 
> in everyone's favor if we took the initiative.

If we take the vendor persåective here. Then why should they make their
driver open source, when the middle layer is not part of the 
main stream kernel?

So short-term I beleive the
"no open source drivers => no interest in IBAL"
is a bit to fast a conclusion.

Let's anyway see what they have, and give them feedback.
Based on the comments I have seen so far there is
a good chance to see open source drivers before IBAL is
considered ready for main stream kernel.

	Sam
