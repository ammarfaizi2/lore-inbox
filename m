Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTEGOTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTEGOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:19:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16256 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263212AbTEGOTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:19:14 -0400
Date: Wed, 7 May 2003 15:31:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Valdis.Kletnieks@vt.edu
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030507143148.GB16023@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <m13cjranqb.fsf@frodo.biederman.org> <20030506215552.GA6284@mail.jlokier.co.uk> <m1vfwn88vu.fsf@frodo.biederman.org> <200305071425.h47EPYxg013048@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071425.h47EPYxg013048@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 07 May 2003 02:21:25 MDT, Eric W. Biederman said:
> 
> > Beyond that the whole closed thing is a turn-off.  Which is likely to
> > reduce interest in your research OS and get you no free feedback on
> > the weird situations.
> 
> The target kernel doesn't actually *have* to be closed.  What if the
> kernel running the Linux driver was some open-but-incompatible licence?

Regarding Eric's point, I think it comes down to what captures the
imagination of potential users.  Even a GPL'd project is not likely to
get much interest if it doesn't offer anything worth using.
Conversely, see BeOS for something which was not ultimately a
commercial success, but which captured the imagination of a lot of
people despite being closed source.

> I'll just pause to point out that the single most successful TCP stack
> has to be the BSD one - which started off as DARPA-funded research, and got
> lots of feedback in spite of its license.

I disagree.  Many of the most successful TCP stacks _forked_ from the
BSD one at some time or other (e.g. SunOS, Microsoft), but then they
evolved in their own directions, with their unique quirks.

-- Jamie

