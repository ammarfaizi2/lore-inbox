Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJCWxL>; Thu, 3 Oct 2002 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJCWxL>; Thu, 3 Oct 2002 18:53:11 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:5129 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261426AbSJCWxK>; Thu, 3 Oct 2002 18:53:10 -0400
Date: Thu, 3 Oct 2002 23:58:42 +0100
From: John Levon <levon@movementarian.org>
To: kernel <linux-kernel@vger.kernel.org>
Cc: rml@tech9.net, davej@codemonkey.org.uk, torvalds@transmeta.com
Subject: Re: export of sys_call_table
Message-ID: <20021003225842.GA79989@compsoc.man.ac.uk>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033684027.1247.43.camel@phantasy>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 06:27:06PM -0400, Robert Love wrote:

> > Hmm, I guess this means oprofile has no chance of working
> > on Red Hat's kernels ? Bummer.
> 
> Newer oprofile does not need the exported syscall table.

Right. Assuming Linus is interested in merging the patch.
I've yet to see any kind of comment from him.

> I believe Red Hat 8.0 even ships with oprofile :)

Sort of. They've broken IA64 oprofile, and they seem not to care.

I'm pretty disgusted Arjan sent this patch without even the courtesy of
a Cc: to lkml (apologies if I just missed it).

regards
john

-- 
"Me and my friends are so smart, we invented this new kind of art:
 Post-modernist throwing darts"
	- the Moldy Peaches
