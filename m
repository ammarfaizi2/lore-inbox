Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135790AbRDTEJo>; Fri, 20 Apr 2001 00:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135792AbRDTEJf>; Fri, 20 Apr 2001 00:09:35 -0400
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:61166 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S135790AbRDTEJX>; Fri, 20 Apr 2001 00:09:23 -0400
Date: Thu, 19 Apr 2001 22:07:22 -0600 (MDT)
From: james rich <james.rich@m.cc.utah.edu>
To: Matthew Wilcox <willy@ldl.fc.hp.com>
cc: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
In-Reply-To: <20010419211749.I4217@zumpano.fc.hp.com>
Message-ID: <Pine.GSO.4.05.10104192201330.8316-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Matthew Wilcox wrote:

> On Thu, Apr 19, 2001 at 11:00:09PM -0400, Eric S. Raymond wrote:
> > What is the right procedure for doing changes like this?  Is "don't
> > touch that tree" a permanent condition, or am I going to get a chance
> > to clean up the global CONFIG_ namespace after your next merge-down?
> 

[snip]

> My preference would be for you to fetch our tree 

> and submit patches to us, which will get to Linus in the fullness of time.

Truly this is not meant to be negative - don't take it as such.

Doesn't this seem a little like the problems occurring with lvm right now?
A separate tree maintained with the maintainers not wanting others
submitting patches that conflict with their particular tree?  It seems
that any project should be able to submit any patch against The One True
Tree: Linus' tree.

James Rich
james.rich@m.cc.utah.edu

