Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKTX4i>; Wed, 20 Nov 2002 18:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSKTX4i>; Wed, 20 Nov 2002 18:56:38 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:19104 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S263105AbSKTX4O>; Wed, 20 Nov 2002 18:56:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
References: <fa.fglehrv.95g32b@ifi.uio.no> <fa.h7et98v.hjm1of@ifi.uio.no>
In-Reply-To: <fa.h7et98v.hjm1of@ifi.uio.no> (Mark Mielke's message of "Wed,
 20 Nov 2002 08:21:20 GMT")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Wed, 20 Nov 2002 16:03:14 -0800
Message-ID: <yl3cpviybh.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Honest Recruiter,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> writes:

> I think this restriction (the need for copyright assignment) only
> applies to code 'incorporated in FSF projects', whatever that means. See
> the GPL FAQ for a rather vague explanation.

> Are 'FSF projects' the packages that can be downloaded from ftp.gnu.org?

Copyright assignments are only needed for projects for which the FSF holds
the copyright and requires copyright assignments, and then only if one
wants one's code to make it into the GNU-distributed version.

I don't believe it is possible to answer that question with more
granularity without going down to a project-by-project check.  There
certainly have been packages available from ftp.gnu.org that do not
require copyright assignments to contribute to.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
