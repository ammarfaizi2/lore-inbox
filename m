Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVDKD0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDKD0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVDKD0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:26:00 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54234 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261678AbVDKDZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:25:37 -0400
Subject: Re: New SCM and commit list
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
References: <1113174621.9517.509.camel@gaston>
	 <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 22:25:22 -0500
Message-Id: <1113189922.9899.6.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 16:26 -0700, Linus Torvalds wrote:
> On Mon, 11 Apr 2005, Benjamin Herrenschmidt wrote:
> > If yes, then I would appreciate if you could either keep the same list,
> > or if you want to change the list name, keep the subscriber list so
> > those of us who actually archive it don't miss anything ;)
> 
> I didn't even set up the list. I think it's Bottomley. I'm cc'ing him just 
> so that he sees the message, but I don't actually expect him to do 
> anything about it. I'm not even ready to start _testing_ real merges yet. 
> But I hope that I can get non-conflicting merges done fairly soon, and 
> maybe I can con James or Jeff or somebody to try out GIT then...

Not guilty.  If I remember correctly, the list was set up by the vger
list maintainers (davem and company).  It was tied to a trigger in one
of your trees (which I think Larry did).  It shouldn't be too difficult
to add to git ... it just means traversing all the added patches on a
merge and sending out mail.

I can try out your source control tools ... I have some rc fixes
ready ... when you're ready to try out merges...

James


