Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUHJWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUHJWbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUHJWas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:30:48 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:32743 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267762AbUHJWae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:30:34 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
	 <20040809212949.GA1120@elf.ucw.cz>
	 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
	 <1092130981.2676.1.camel@laptop.cunninghams>
	 <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092176983.2709.3.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 11 Aug 2004 08:29:43 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-08-10 at 23:58, Patrick Mochel wrote:
> On Tue, 10 Aug 2004, Nigel Cunningham wrote:
> 
> > Do you want me to merge before or after all this is done; I'm a bit
> > concerned that you guys are expending effort (well, Pavel is), getting
> > SMP and Highmem going when I already have a working version that -
> > unless the plans have changed - we were intending to merge too.
> 
> It would be nice if you posted small easily-consumable patches that
> gradually merged the two. Even if you post them all at once, it provides
> something to review and an understanding of how one evolves into the
> other.

I'm not intending to patch the current implementation into the new
version; there are so many changes that it would make the process
extremely painful (as evolution would have been if it were really true).
Instead, I proposed, as Andrew requested to post a number of patches
simply adding the new version along side the old. When you're satisfied
that the new does everything the old does, I'm hoping we'll simply drop
the old version.

I'll start producing patches shortly, then.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

