Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312330AbSCYIVD>; Mon, 25 Mar 2002 03:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCYIUw>; Mon, 25 Mar 2002 03:20:52 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:39181 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S312330AbSCYIUe>; Mon, 25 Mar 2002 03:20:34 -0500
Date: Mon, 25 Mar 2002 08:20:30 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Nice values for kernel modules
Message-ID: <20020325082029.GA41624@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet.suse.lists.linux.kernel> <E16mICa-0006mr-00@the-village.bc.nu.suse.lists.linux.kernel> <p73d6y4187b.fsf@oldwotan.suse.de> <m1pu1tum0g.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:47:27AM -0700, Eric W. Biederman wrote:

> What is wrong with using ptrace?  That should already give you a hook into
> every syscall.

it's too slow, and how do you manage to follow every process ?

regards
john

-- 
"Way back at the beginning of time around 1970 the first man page was
 handed down from on high. Every one since is an edited copy."
	- John Hasler <john@dhh.gt.org>
