Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbSJBUGR>; Wed, 2 Oct 2002 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJBUGR>; Wed, 2 Oct 2002 16:06:17 -0400
Received: from 62-190-217-232.pdu.pipex.net ([62.190.217.232]:38156 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262589AbSJBUGP>; Wed, 2 Oct 2002 16:06:15 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210022019.g92KJSNr001989@darkstar.example.net>
Subject: Re: your mail
To: peloquin@us.ibm.com (Mark Peloquin)
Date: Wed, 2 Oct 2002 21:19:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <OF527144DA.FA032B8F-ON85256C46.0065456B@pok.ibm.com> from "Mark Peloquin" at Oct 02, 2002 02:58:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-10-02 at 17:09, Alan Cox wrote:
> > Look at history - if such a mess got in, it would never get sorted.
> 
> Instead of throwing around vague statements with little
> context like "compost heap" and "such a mess", why don't
> you spell out the specific design points of EVMS that you
> disagree with. The advantages and disadvantages of
> each point can then be discussed.

Yeah, but he is right in any case - look how the IDE mess of 2.5.x, which, frankly, I don't believe was ever as bad as people seem to be saying it was, has put people off testing 2.5.x.  Instead they are waiting for Linus to type

mv linux-2.5.x linux-2.6.0

at which point they think that all remaining bugs will auto-magically correct themselves and the tree is one again safe to use.  WRONG answer!

Simply from the point of view of not wanting to 'scare off' people from a whole tree, (which is so rediculous, I think I'll go and patent it), and as a result get less testing, we're better off trying to stop weirdness from getting in.

John.

