Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSA3JTr>; Wed, 30 Jan 2002 04:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSA3JTh>; Wed, 30 Jan 2002 04:19:37 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:22021 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289000AbSA3JTU>; Wed, 30 Jan 2002 04:19:20 -0500
Date: Wed, 30 Jan 2002 09:19:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130091912.A16937@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0201291719070.24557-100000@verdande.oobleck.net> <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 04:44:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 04:44:12PM -0800, Linus Torvalds wrote:
> I have to admit that personally I've always found the MAINTAINERS file
> more of an irritation than anything else. The first place _I_ tend to look
> personally is actually in the source files themselves (although that may
> be a false statistic - the kind of people I tend to have to look up aren't
> the main maintainers at all, but more single driver people etc).
> 
> It might not be a bad idea to just make that "mention maintainer at the
> top of the file" the common case.

There's one problem with that though - if someone maintains many files,
and his email address changes, you end up with a large patch changing all
those email addresses in every file.

IMHO its far better to have someone's name at the top of each file, and
put the email addresses in the MAINTAINERS file.

People don't change their names often, but email addresses do change.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

