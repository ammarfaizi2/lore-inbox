Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132920AbRDQWd7>; Tue, 17 Apr 2001 18:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbRDQWdt>; Tue, 17 Apr 2001 18:33:49 -0400
Received: from relay1.pair.com ([209.68.1.20]:60168 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S132918AbRDQWdc>;
	Tue, 17 Apr 2001 18:33:32 -0400
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010417223234.15095.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA2E@berkeley.gci.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Leif Sawyer's message of "Tue, 17 Apr 2001 11:09:09 -0800"
Organization: rows-n-columns
Date: 18 Apr 2001 08:32:34 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com> writes:

> Jesse Pollard replies:
> to Leif Sawyer who wrote: 
> > > Besides, what would be gained in making the counters RO, if 
> > > they were cleared every time the module was loaded/unloaded?
> > 
> > 1. Knowlege that the module was reloaded.
> > 2. Knowlege that the data being measured is correct
> > 3. Having reliable measures
> > 4. being able to derive valid statistics

> Good.  Now that we have valid objectives to reach, which of these
> are NOT met by making the fixes entirely in userspace, ...

By this logic you could ask why we need separate user spaces,
just fix all applications so they cooperate nicely.

> They're still all met, right?

No.  Because they require well behaved, cooperative user programs.

> And we haven't had to fill the kernel with more cruft.

Nonsense.  Removing counter reset capabilities reduces kernel cruft.

-- 
Manfred Bartz
