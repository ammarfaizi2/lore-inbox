Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274053AbRISNmP>; Wed, 19 Sep 2001 09:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274061AbRISNmG>; Wed, 19 Sep 2001 09:42:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62217 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274053AbRISNlw>;
	Wed, 19 Sep 2001 09:41:52 -0400
Date: Wed, 19 Sep 2001 10:42:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, <torvalds@transmeta.com>,
        <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918221748.1f51f801.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0109191040370.4279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Stephan von Krawczynski wrote:

> Hm, I guess if anybody would be capable of _really_ fixing vm in
> upto-pre10 state, he would have done it already. It's not that people
> would not have tried, but it looks like nobody is able to get the
> _whole_ picture of this.

Look, the problem is that Linus is being an asshole and
integrating conflicting ideas into both the VM and the
VFS, without giving anybody prior notice and later blame
others.

Just look at how he's now trying to force Al Viro into
implementing his ideas yesterday because he broke stuff
again...

If you want a stable kernel, use Alan's kernel.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

