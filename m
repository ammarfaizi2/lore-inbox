Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278286AbRJSDDw>; Thu, 18 Oct 2001 23:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278282AbRJSDDn>; Thu, 18 Oct 2001 23:03:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45839 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278283AbRJSDDb>;
	Thu, 18 Oct 2001 23:03:31 -0400
Date: Fri, 19 Oct 2001 01:03:47 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Tim Walberg <twalberg@mindspring.com>, James Sutherland <jas88@cam.ac.uk>,
        Ben Greear <greearb@candelatech.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <15311.31962.850647.50079@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33L.0110190103000.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001, Neil Brown wrote:
> On Thursday October 18, twalberg@mindspring.com wrote:
> > A semi-random thought on the tree-quota concept:
> >
> > Does it really make sense to charge a tree quota to a single specific
> > user? I haven't really looked into what would be required to implement
> > it, but my mental picture of a tree quota is somewhat divorced from the
> > user concept,

> However I actually want to charge usage to users.
> There is a natural mapping from users to directory trees via the
> concept of the home-directory.

Say ... /home/students   ?


Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

