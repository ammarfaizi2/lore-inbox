Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWFPODz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFPODz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFPODz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:03:55 -0400
Received: from thunk.org ([69.25.196.29]:64483 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751405AbWFPODy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:03:54 -0400
Date: Fri, 16 Jun 2006 10:03:34 -0400
From: Theodore Tso <tytso@mit.edu>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bcollins@ubuntu.com, akpm@osdl.org
Subject: Re: reviewing Ubuntu kernel patches
Message-ID: <20060616140334.GA24491@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, bcollins@ubuntu.com, akpm@osdl.org
References: <44909A1D.3030404@oracle.com> <1150386150.2987.9.camel@laptopd505.fenrus.org> <44924425.1040501@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44924425.1040501@oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 10:39:49PM -0700, Randy Dunlap wrote:
> Certainly a good question IMO.  If Andrew or Linus knows whether
> I need to add my Signed-off-by, I'll be glad to listen.
> (That's not a general call for opinions.)

If you're submitting the patch, then surely you need to add your
Signed-off-by:, since you're asserting either (b) or (c):

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

We've gotten into the habit of assuming the Signed-off-by: also has
the meaning of "I vouch for it from technical point of view", but
really, that's presumably true since otherwise you wouldn't have
e-mailed it to Andrew or Linus.  The original meaning of the
Signed-off-by: is in the Developer's Certificate of Origin
statement...

						- Ted
