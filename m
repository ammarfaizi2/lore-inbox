Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVDJEUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDJEUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 00:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVDJEUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 00:20:25 -0400
Received: from c-65-96-98-23.hsd1.ma.comcast.net ([65.96.98.23]:25986 "EHLO
	h0040333b7dc3.ne.mediaone.net") by vger.kernel.org with ESMTP
	id S261429AbVDJEUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 00:20:15 -0400
Date: Sun, 10 Apr 2005 00:20:12 -0400
From: Glenn Maynard <glenn@zewt.org>
To: debian-legal@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050410042012.GC18141@zewt.org>
Mail-Followup-To: debian-legal@lists.debian.org,
	linux-kernel@vger.kernel.org
References: <874qegkxjp.fsf@kreon.lan.henning.makholm.net> <MDEHLPKNGKAHNMBLJOLKEELGDAAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEELGDAAB.davids@webmaster.com>
Mail-Copies-To: nobody
X-No-CC: Branden subscribes to this list; do not CC him on replies.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Henning Makholm, I assume; I seem to be missing the actual message and
David's mailer forgot to put a quote header on the original reply):

> > >> I think the "derivative work" angle is a red herring. I do not think
> > >> that either of the two parts that are being linked together (i.e. the
> > >> driver and the firmware) are derivates of the other.  The relevant

The two parts are not derivatives of each other, of course; that's
obvious.  (If I take your firmware, David's firmware loader, and link
them together, I havn't change either of your works.)  The resulting
linked binary, however, is a derivative work of both.

I've heard the claim, several times, that that creating a derivative
work requires creative input, that linking stuff together with "ld" is
completely uncreative, therefore no derivative work is created.  (I'm
not sure if you're making (here or elsewhere) that claim, but it seems
like it.)  What's the basis for this claim?  (If you're not making it,
anybody that does believe this is free to respond.)

The case David referred to[1] says "A derivative work may itself be
copyrighted if it has the requisite originality."  This seems to imply
that something can be a derivative work without creative input (though
no new copyright would exist beyond that of the source objects).  It
seems that while "creative input" is required for copyright to exist,
it is not required for creating a derivative work.

[1] http://caselaw.lp.findlaw.com/data2/circs/8th/033112p.pdf

On Sat, Apr 09, 2005 at 08:07:03PM -0700, David Schwartz wrote:
> 	The way you stop someone from distributing part of your work is by arguing
> that the work they are distributing is a derivative work of your work and
> they had no right to *make* it in the first place. See, for example, Mulcahy
> v. Cheetah Learning.

Er, that's one way, but not *the* way.  I could grant you permission to
create derivatives of my work, but not to redistribute them.  To stop you
from distributing them, I'd argue that you had no right to distribute
them--you *did* have the right to make it in the first place.

The GPL does this.  Note GPL #2b: "any work that you distribute or publish".
If you don't distribute or publish the derivative work, the work does not
need to be "licensed ... under the terms of this License."  It very carefully
separates the permissions granted for merely creating a derivative work,
and the permissions granted for distributing those works; if you distribute
a linked binary in violation of the GPL, you may very well have had permission
to make it in the first place.

(Of course, if whether the work is a derivative is in question, that would
need to be established--you would, indeed, need to argue that the work they
are distributing is a derivative work--but you wouldn't necessarily further
argue that they had no right to make it in the first place.)

-- 
Glenn Maynard
