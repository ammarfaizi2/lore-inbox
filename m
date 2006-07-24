Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWGXKan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWGXKan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 06:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGXKan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 06:30:43 -0400
Received: from thunk.org ([69.25.196.29]:49115 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932105AbWGXKam (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 06:30:42 -0400
Date: Mon, 24 Jul 2006 06:30:23 -0400
From: Theodore Tso <tytso@mit.edu>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724103023.GA7615@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17604.31844.765717.375423@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 11:53:08AM +0400, Nikita Danilov wrote:
> 
> I believe the (mis-)reference is to a famous data-base person, co-author
> of "Transaction Processing". He is with Microsoft now
> (http://research.microsoft.com/~Gray/JimGrayHomePageSummary.htm).
> 

That's what I thought when I saw the name Jim Gray, but as far as I
knew he never worked on XFS and never left the Linux community
dejected because Linux kernel coding standards requirements before
changes were allowed to be merged, when Hans did his name dropping
thing.

(I mean geez, if you want really high standards before new code is
accepted, take a look at Open Solaris; they have *such* a heavyweight
process, with two mandatory signoffs by core Solaris engineers who
both have to do a line-by-line review, and with a promise of on-disk
and ABI compatibility *forever* ---- that we do more commits in a week
than they do in a year....)

						- Ted
