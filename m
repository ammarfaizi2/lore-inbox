Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269222AbTCBBUz>; Sat, 1 Mar 2003 20:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbTCBBUz>; Sat, 1 Mar 2003 20:20:55 -0500
Received: from slider.rack66.net ([212.3.252.135]:32406 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP
	id <S269222AbTCBBUy>; Sat, 1 Mar 2003 20:20:54 -0500
Date: Sun, 2 Mar 2003 02:37:36 +0100
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030302013736.GC6293@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303020011.QAA13450@adam.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 04:11:55PM -0800, Adam J. Richter wrote:
> Pavel Machek wrote:
> > I've created little project for read-only (for now ;-) kitbeeper
> > clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> > just get it fresh from CVS).
> 
> 	Thank you for taking some initiative and improving this
> situation by constructive means.  You are an example to us all,
> as is Andrea Arcangeli with his openbkweb project, which you
> will probably want to examine and perhaps integrate
> (ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/openbkweb).

I've said this (indirectly) before, and I'll say it again:
BitBucket, and you, are missing the point here. Openbkweb isn't.
Before one can use bitbucket there still has to be a bkbits mirror first,
which incidentally may be true for the main linux kernel trees but isn't
for other projects developed with the help of bitkeeper.

I've also said this before, and I'll also repeat this again:
While politics & philosophy are my main reasons not to use bitkeeper, I
also am not bothered enough by other issues to use it plain and simple.
Nor to use openbkweb instead. And I'm not going to tell other people what
they should do.

However, until we have a tool (as openbkweb tries to be, although very
inefficiently) which can extract patches from the "main" openlogging
bitkeeper repositories, the schism remains between developers who use BK
and those who cannot use it - be it for political or real legal (i.e.
license violation, because of involvement in another SCM) reasons.

> bitkbucket currently uses rsync to update data from the
> repository.
(...)
> 	I think the suggestion made by Pavel Janik that it would
> be better to work on adding BitKeeper-like functionality to existing
> free software packages is a bit misdirected.  BitKeeper uses SCCS
> format, and we have a GPL'ed SCCS clone ("cssc"), so you are
> adding functionality to existing free software version control
> code anyhow.

Not until you can use that functionality to access the main BK
repositories directly. When you're still accessing mirrors of it, as in
the rsync case, you are - pragmatically speaking - no better of than when
not accessing it at all.


Regards,

Filip

-- 
"To me it sounds like Cowpland just doesn't know what the hell he is talking
 about.  That's to be expected: he's CEO, isn't he?"
	-- John Hasler
