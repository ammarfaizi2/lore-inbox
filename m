Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284235AbRLFUpQ>; Thu, 6 Dec 2001 15:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLFUhu>; Thu, 6 Dec 2001 15:37:50 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:62725 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284237AbRLFUhB>; Thu, 6 Dec 2001 15:37:01 -0500
Date: Thu, 6 Dec 2001 13:02:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Paul.Clements@steeleye.com
Cc: Edward Muller <emuller@learningpatterns.com>, linux-kernel@vger.kernel.org
Subject: Re: Current NBD 'stuff'
Message-ID: <20011206130220.B49@toy.ucw.cz>
In-Reply-To: <1007402546.3824.9.camel@akira.learningpatterns.com> <Pine.LNX.4.10.10112041644170.17617-400000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10112041644170.17617-400000@clements.sc.steeleye.com>; from kernel@steeleye.com on Tue, Dec 04, 2001 at 05:26:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> 
> > Anyone know where I can find the latest NBD stuff? Esp. client/server
> > code?
> 
> I have the same question. Maybe the user-level stuff is not being 
> actively maintained?
> 
> However, since we couldn't find current versions of this stuff, 
> my colleagues and I patched nbd-server and the nbd kernel module 
> to fix a few bugs and to make them a little more robust. I'll
> attach my versions of those files (which I think are derived from
> Pavel's .14.tar.gz versions).

Do not comment code by //. Kill if it you want to.

You added clean way to stop nbd. Good.

DO NOT USE ALL CAPITALS not even in printks().

Fix those and patch looks ike good idea for 2.5.

Look at nbd.sf.net. If you have patches against that, mail them to me. If 
you are willing to co-develop stuff at nbd.sf.net, I guess we can arrange
something.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

