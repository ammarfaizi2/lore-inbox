Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265046AbRFURFj>; Thu, 21 Jun 2001 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265043AbRFURFa>; Thu, 21 Jun 2001 13:05:30 -0400
Received: from pat.uio.no ([129.240.130.16]:37585 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265044AbRFURFR>;
	Thu, 21 Jun 2001 13:05:17 -0400
To: Christian Robottom Reis <kiko@async.com.br>
Cc: <NFS@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>
Subject: Re: [NFS] NFS insanity
In-Reply-To: <Pine.LNX.4.32.0106202015380.2976-100000@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Jun 2001 17:10:38 +0200
In-Reply-To: Christian Robottom Reis's message of "Wed, 20 Jun 2001 20:23:06 -0300 (BRT)"
Message-ID: <shsae31yikx.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Robottom Reis <kiko@async.com.br> writes:

     > It _only_ happens in this file of all files I've tried out so
     > far. I'm trying to get xdelta to show me what's differing so I
     > can see if there's a pattern or something, but it's awful -
     > data corruption not only possibly but happening. :-)

     > I haven't tried remounting yet to see what I get, but I don't
     > see the problems on unpatched 2.4.2. I'll wait a bit to see if
     > anyone has seen this. Anyone?

Are you perchance using soft mounts?

Cheers,
  Trond
