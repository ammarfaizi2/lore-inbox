Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGQQQP>; Wed, 17 Jul 2002 12:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSGQQQP>; Wed, 17 Jul 2002 12:16:15 -0400
Received: from ns.suse.de ([213.95.15.193]:48644 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315282AbSGQQQN>;
	Wed, 17 Jul 2002 12:16:13 -0400
Date: Wed, 17 Jul 2002 18:19:02 +0200
From: Dave Jones <davej@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 17, 2002
Message-ID: <20020717181901.G18170@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D34C75C.13697.11D651E4@localhost> <Pine.LNX.4.33L2.0207170908060.29653-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0207170908060.29653-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 09:10:19AM -0700, Randy.Dunlap wrote:
 > | With the code freeze date approaching soon, it is obvious that many
 > Oct. 31 is feature freeze date, or so several of us understood.

yep.

 > | of these projects will not get merged in the next 3 months.
 > | What would you rather me do?  Keep them in here just for reference,
 > | mark them as post-code freeze or just delete them?
 > I think that you have more than 3 months to continue updating this.  :)

It would actually be useful to have some more people propose input
on Guillaume's list at some point, or even to suggest removal of
items unlikely to happen.

 > | o Started     Reorder x86 initialization                      (Dave Jones,
 > | Randy Dunlap)
 > Please change this one to Pat Mochel.

There's also a lot of cross-over with this item and the
x86 subarch support which James Bottomley has been working on.
I've been kicking that patch around a little the last few days,
and I'll be merging it soon, so we can get a taste for how
arch/i386/ *could* look.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
