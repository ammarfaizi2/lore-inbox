Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbUDBVhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUDBVhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:37:33 -0500
Received: from gprs214-45.eurotel.cz ([160.218.214.45]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264187AbUDBVfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:35:15 -0500
Date: Fri, 2 Apr 2004 23:35:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ross Biro <ross.biro@gmail.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402213504.GA246@elf.ucw.cz>
References: <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <2B32499D.222B761B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B32499D.222B761B@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Pá 02-04-04 11:28:55, Ross Biro wrote:
> On Fri, 2 Apr 2004 20:23:58 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > If you really want cowlinks and hardlinks to be intermixed freely, I'd
> > > > > happily agree with you as soon as you can define the behaviour for all
> > > > > possible cases in a simple document and none of them make me scared
> > > > > again.  Show me that it is possible and makes sense.
> 
> Maybe it's easiest to view the proposed copyfile() as being
> semantically equivalent to cp from the point of view of anything above
> the actual file system (modulo running out of space at weird times)

Yes, this is what I was trying to propose.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
