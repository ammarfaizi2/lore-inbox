Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUEWVld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUEWVld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbUEWVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:41:33 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13228 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263611AbUEWVlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:41:32 -0400
Date: Sun, 23 May 2004 23:41:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040523234113.A20413@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085334933.8494.1448.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1085334933.8494.1448.camel@localhost.localdomain>; from joe@perches.com on Sun, May 23, 2004 at 10:55:33AM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> :
[...]
> Use of BK has lost some of the "many-eyeballs" positives of the past.
> Today's BkCommits-Head list only allows an after-the-fact review.
> Frequently, the patch author and sometimes the maintainer are the
> only parties to the change.  A pre-commit list could allow comments by
> interested parties on patches that today are under reviewed.

"Die Hard and Linux pre-commit" ?

If people want to review things, there are:
- -mm
- linus -rc
- linux-scsi
- linux-ide
- netdev
- janitor
- bk-commit
- dri (under what ?)
etc.

Imho the (more or less) specialized lists and bk-commit do not work too bad.

--
Ueimor
