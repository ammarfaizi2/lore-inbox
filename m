Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVAMDkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVAMDkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVAMDkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:40:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261388AbVAMDkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:40:03 -0500
Date: Wed, 12 Jan 2005 22:37:55 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050112161227.GF32024@logos.cnet>
Message-ID: <Pine.LNX.4.61.0501122235240.27051@chimarrao.boston.redhat.com>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Marcelo Tosatti wrote:

> The only reason for this is to have "time for the vendors to catch up", 
> which can be defined by the kernel security office. Nothing more - no 
> vendor politics involved.

There are other good reasons, too.  One could be:

"Lets not make this security bug public on christmas eve,
  because many system administrators won't get around to
  applying patches, while the script kiddies have lots of
  time over their christmas holidays."

IMHO it will be good to coordinate things like this, based on
common sense, and trying to minimise the impact on users of
the software.  I do agree with Linus' "no politics" point,
though ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
