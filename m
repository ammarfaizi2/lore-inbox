Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTAVHBm>; Wed, 22 Jan 2003 02:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTAVHBm>; Wed, 22 Jan 2003 02:01:42 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:19156 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267356AbTAVHBl>;
	Wed, 22 Jan 2003 02:01:41 -0500
Date: Wed, 22 Jan 2003 07:10:28 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hua Zhong <huaz@sbcglobal.net>
Cc: David Schwartz <davids@webmaster.com>, dana.lacoste@peregrine.com,
       linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030122071028.GA3466@bjl1.asuk.net>
References: <CDEDIMAGFBEBKHDJPCLDCEEKCFAA.huaz@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDEDIMAGFBEBKHDJPCLDCEEKCFAA.huaz@sbcglobal.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
> > 	First, I would in fact prefer to have the version control
> > information to make changes. The commit comments, for example, may
> > explain the rationale for changes.
> 
> These comments are not part of the source. The source has its own comments.
> They are helpful when you try to track the changes, but GPL doesn't require
> releasing the tracking record of a GPL project.

> It only requires releasing the whole source (or diff).

No, a "diff" is _not_ sufficient when releasing a modified binary -
you must provide, or offer to provide, the whole source used to make
that binary.

People differ in what they think the "whole source" means.  The GPL
defines what _it_ means by the source code for a work, and that is the
definition you are bound by, but even that definition is understood
differently by different people.  It is the nuances of that definition
that are being discussed in this thread.

I agree with Larry that clear boundaries will be found in case law, as
and when they are required, and that meeting minutes and repository
metadata probably are not considered part of the source code.

It is just tough luck that you miss out on useful information.

In addition, even if Linus refused to work with someone who did not
use the repository, that is also tough luck.  You have the right to
fork the project; the GPL does not give you the right to work with Linus.

However if there was a project where the repository was _essential_ to
do any meaningful work on the project, I suspect that a court of law
would find that the repository is considered part of the source code
per the GPL's definition.

(Note: I am not a lawyer nor have I paid for any advice.)

> The argument that "BK hosts GPL project so BK has to be GPL'd" is also
> ridiculous.

Please be careful when making logical statements.

Nobody, not even David, has made that argument.  His argument is that
"BK hosts GPL project so the repository _of that project_ has to be GPL'd".

It has nothing to do with BK, in fact.

-- Jamie
