Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTENSyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTENSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:54:52 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:35033 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263592AbTENSys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:54:48 -0400
Date: Wed, 14 May 2003 21:07:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Dean McEwan <dean_mcewan@linuxmail.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Digital Rights Management - An idea (limited lease, renting, expiration, verification) NON HAR*D*WARE BASED.
Message-ID: <20030514190728.GA3478@louise.pinerecords.com>
References: <20030514152247.4146.qmail@linuxmail.org> <20030514161308.GA10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514161308.GA10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [viro@parcelfarce.linux.theplanet.co.uk]
> 
> On Wed, May 14, 2003 at 03:22:46PM +0000, Dean McEwan wrote:
> > > That way around doesnt actually work because I'll simply lie, fake the server or firewall you
> > 
> > Encrypted binary, in a XML wrapper that needs decryption key from owners site.
> > Uses port 80...
> 
> ... and is declared a firing offense.  BTW, the privacy issues (and related
> information leak/blackmail potential) are mind-boggling - it's not just
> "some guy bought $material", it's "this guy had accessed $material at
> $list_of_times".
> 
> And that's besides being unable to use the FPOS in question on a laptop,
> going tits-up whenever a backhoe finds your cable, doing the same when
> vendor's boxen get screwed, yadda, yadda.
> 
> Crap idea.

Totally.

Two more problems:

1)  In this case the decryption key is an intergral part of the software
and as such needs to be supplied as per fair use clauses.

2)  Alan's argument stands.  It is possible to fake the server and provide
the key once the user have pinched a working copy.  The wrapper can be
reverse-engineered for communication key magics if need be.

-- 
Tomas Szepe <szepe@pinerecords.com>
