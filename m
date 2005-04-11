Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVDKVCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVDKVCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVDKVCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:02:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:4532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbVDKVAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:00:47 -0400
Date: Mon, 11 Apr 2005 13:53:23 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: New SCM and commit list
Message-ID: <20050411205317.GA26246@kroah.com>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org> <1113189922.9899.6.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113189922.9899.6.camel@mulgrave>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 10:25:22PM -0500, James Bottomley wrote:
> On Sun, 2005-04-10 at 16:26 -0700, Linus Torvalds wrote:
> > On Mon, 11 Apr 2005, Benjamin Herrenschmidt wrote:
> > > If yes, then I would appreciate if you could either keep the same list,
> > > or if you want to change the list name, keep the subscriber list so
> > > those of us who actually archive it don't miss anything ;)
> > 
> > I didn't even set up the list. I think it's Bottomley. I'm cc'ing him just 
> > so that he sees the message, but I don't actually expect him to do 
> > anything about it. I'm not even ready to start _testing_ real merges yet. 
> > But I hope that I can get non-conflicting merges done fairly soon, and 
> > maybe I can con James or Jeff or somebody to try out GIT then...
> 
> Not guilty.  If I remember correctly, the list was set up by the vger
> list maintainers (davem and company).  It was tied to a trigger in one
> of your trees (which I think Larry did).  It shouldn't be too difficult
> to add to git ... it just means traversing all the added patches on a
> merge and sending out mail.
> 
> I can try out your source control tools ... I have some rc fixes
> ready ... when you're ready to try out merges...

I have some rc fixes too, let us know when you are ready to accept them,
and what format you want them in.

I have a feeling that the kernel.org mirror system is just going to
_love_ us using it to store temporary git trees :)

thanks,

greg k-h
