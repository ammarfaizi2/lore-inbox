Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSKSCdx>; Mon, 18 Nov 2002 21:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSKSCdx>; Mon, 18 Nov 2002 21:33:53 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:48132 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261398AbSKSCdw>; Mon, 18 Nov 2002 21:33:52 -0500
Date: Tue, 19 Nov 2002 02:40:32 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021119024032.GA99837@compsoc.man.ac.uk>
References: <20021118230821.8F3822C241@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118230821.8F3822C241@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18DyJU-000CkV-00*8Hh21B6HCQo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:58:56AM +1100, Rusty Russell wrote:

>    The previous code required to implement the two module loading
>    system call, the module querying system call, and the /proc/ksyms
>    output, required a little more code than the current x86 linker.

This makes it sound like you're not bringing /proc/ksyms back (or an
equivalent to let userspace know where modules are loaded). I hope this
isn't the case...

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
