Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTCECXA>; Tue, 4 Mar 2003 21:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTCECXA>; Tue, 4 Mar 2003 21:23:00 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:36356 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267033AbTCECXA>;
	Tue, 4 Mar 2003 21:23:00 -0500
To: Daniel Phillips <phillips@arcor.de>
Cc: ext2-devel@lists.sf.net, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 htree brelse problems look to be fixed!
References: <m3of4q4rdl.fsf@lugabout.jhcloos.org>
	<20030305013347.F0C9CECEC3@mx12.arcor-online.net>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030305013347.F0C9CECEC3@mx12.arcor-online.net>
Date: 04 Mar 2003 21:32:44 -0500
Message-ID: <m33cm24k6r.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@arcor.de> writes:

Daniel> Good that it's working for you, but it's not quite the last
Daniel> issue.  There is some apparent cache thrashing to track down,
Daniel> and I believe there's still an outstanding NFS issue.

Yes, I forgot about nfs.  But at least, ignoring nfs again, corruption
type issues seem to be fixed.

I guess my post was a bit exuberant....  :-/

-jimc

