Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUFRLKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUFRLKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUFRLKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:10:05 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:62105 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S265109AbUFRLJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:09:59 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
From: mdpoole@troilus.org
References: <200406180656.i5I6udn14886@adam.yggdrasil.com>
Date: Fri, 18 Jun 2004 07:09:57 -0400
In-Reply-To: <200406180656.i5I6udn14886@adam.yggdrasil.com> (Adam J.
 Richter's message of "Thu, 17 Jun 2004 23:56:39 -0700")
Message-ID: <87k6y5w29m.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:

> On Thu, Jun 17, 2004 at 04:22:42PM -0400, mdpoole@troilus.org wrote:
>> http://www.ipwatchdog.com/equitable_estoppel.html discusses equitable
>> estoppel vis-a-vis patent rights (which are treated similarly to
>> copyrights by many courts).  When you contributed your changes to the
>> USB maintainers, they -- and later redistributors -- inferred that you
>> would not allege copyright infringement by applying your changes to
>> the kernel that existed then.
>
> 	From my reading of that web page, it does not seem to me
> that one would have a case of either equitable estoppel or implied
> license (for example, "silence alone is generally not sufficient
> affirmative conduct to give rise to estoppel").  I've made my
> opposition to the illegal drivers clear from the time that I've
> been aware of them.

Really?  I see that one of the previous authors listed on your
copyright filing is Hugh Blemings, listed as "author of keyspan
support for Linux."  I will repeat my question: Did you really do
copyrightable work on the USB serial drivers yet somehow fail to
notice the many firmware header files already there?

> 	If you are not fabricating claims about inferences
> by "the USB maintainers [...] and later distributors", I would
> be interested in your citing some historical examples of the
> "USB mainatiners" stating this inference and not being corrected.

They need not have stated it explicitly; they just have to have relied
on it.  People who are sent patches by the patch's author infer by
that submission that including the patch(es) will not lead to claims
of copyright infringement by that author.  This is common sense.  If
you have any example where someone rejected a patch from the patch's
author out of concern for copyright infringement claims by that
author, I'd like to see it.

There was recent in-depth discussion on debian-legal about further
reasons that would bar your claim of copyright infringement.  Since
you declined to answer all of what I wrote before, I will not bore you
by repeating those arguments here.

Michael
