Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTLJUiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTLJUiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:38:22 -0500
Received: from thunk.org ([140.239.227.29]:43709 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263921AbTLJUiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:38:21 -0500
Date: Wed, 10 Dec 2003 15:37:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Andre Hedrick <andre@linux-ide.org>, Valdis.Kletnieks@vt.edu,
       Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210203710.GC31300@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Andre Hedrick <andre@linux-ide.org>, Valdis.Kletnieks@vt.edu,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100512480.3805-100000@master.linux-ide.org> <03121009022103.31567@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03121009022103.31567@tabby>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:02:21AM -0600, Jesse Pollard wrote:
> 
> You are still deriving your binary from a GPL source when a module is loaded.
> The kernel relocation symbols themselves are under GPL.
> 

Even if the relocation symbols are under GPL'ed (there is doubt
whether such symbols are copyrightable --- since things like telephone
numbers are not copyrightable, for example), there is still the issue
that the user is the one which is loading the module, not the person
writing and distributing the module.  And at this point, given that
the GPL itself says that it's all about distribution, not about the
use of the GPL'ed software, not to mention the fair use doctrine
(trust me, the open source community does **not** want to narrow what
is considered fair use), there isn't a problem.

						- Ted
