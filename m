Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312943AbSDGET3>; Sat, 6 Apr 2002 23:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDGET2>; Sat, 6 Apr 2002 23:19:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58937 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312943AbSDGET1>; Sat, 6 Apr 2002 23:19:27 -0500
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <m18z80nrxc.fsf@frodo.biederman.org>
	<1768408346.1018123250@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2002 21:12:49 -0700
Message-ID: <m14riono3i.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:

> > Sorry wrong set of patches.  I'm not pushing my kexec stuff quite as
> > hard.  It is a little lower on my priority list.  Basically the work
> > is to allow Linux to boot Linux directly.
> 
> Looks great - thanks. I'll try this out next week sometime. 2.5.7
> doesn't work on these boxes for some reason we haven't debugged yet,
> so I'll try this on 2.4 ... if that doesn't work, we'll have to get
> 2.5 working first ;-)

2.4 should work.  I'm just trying to get this all in the kernel
and 2.5 is the more appropriate location to work against.

Eric

