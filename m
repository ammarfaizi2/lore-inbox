Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVBKRat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVBKRat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVBKR2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:28:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262294AbVBKRYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:24:34 -0500
To: lm@bitmover.com (Larry McVoy)
Cc: "Theodore Ts'o" <tytso@mit.edu>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050204233153.GA28731@electric-eye.fr.zoreil.com>
	<20050205193848.GH5028@deep-space-9.dsnet>
	<20050205233841.GA20875@bitmover.com>
	<20050208154343.GH3537@crusoe.alcove-fr>
	<20050208155845.GB14505@bitmover.com>
	<ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050209155113.GA10659@bitmover.com>
	<or7jlgpxio.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050210222403.GA5920@thunk.org>
	<or650z6syt.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050211155351.GB16507@bitmover.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 11 Feb 2005 15:24:17 -0200
In-Reply-To: <20050211155351.GB16507@bitmover.com>
Message-ID: <or7jlf57su.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2005, lm@bitmover.com (Larry McVoy) wrote:

> You are also right that figuring out the merges is a pain.  So what?
> We never said that we'd figure out how to do all this well and then
> teach you how to do it well.  

We're not asking for you to teach us how to do it.  We're just asking
you to let us know the information that is (presumably) stored in the
repository.  Now if you tell me the information isn't stored there at
all, you just throw it away at check in time and then figures it all
out again on the fly upon request, fine, I'll believe you.  I just
wouldn't have thought that's the way it works.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
