Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311640AbSCNQD7>; Thu, 14 Mar 2002 11:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSCNQDs>; Thu, 14 Mar 2002 11:03:48 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:27555 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311640AbSCNQDk>;
	Thu, 14 Mar 2002 11:03:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dan Kegel <dkegel@ixiacom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
Date: Thu, 14 Mar 2002 16:58:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ulrich Drepper <drepper@redhat.com>, darkeye@tyrell.hu, libc-gnats@gnu.org,
        gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org,
        babt@us.ibm.com
In-Reply-To: <E16lK2q-000811-00@the-village.bc.nu> <3C8FF822.D4F38B09@ixiacom.com>
In-Reply-To: <3C8FF822.D4F38B09@ixiacom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lXcJ-0000Rt-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 02:08 am, Dan Kegel wrote:
> Alan Cox wrote:
> > Kernel support is not needed  for this, do it in user space. Or prove it
> > has to be in kernel space
> 
> I'm all in favor of a userspace fix.  I suggested a patch
> to glibc to fix this.  Ulrich rejected it; I'm trying
> to coax out of him how he thinks profiling of multithreaded
> programs on Linux should be fixed.

I find it odd he vetoed your fix and didn't suggest an alternative.

/me checks to make sure this is cc'd to Ulrich.

-- 
Daniel
