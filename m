Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbREFHDq>; Sun, 6 May 2001 03:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133061AbREFHDg>; Sun, 6 May 2001 03:03:36 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:28679 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133040AbREFHDW>;
	Sun, 6 May 2001 03:03:22 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105060703.f46738N323914@saturn.cs.uml.edu>
Subject: Re: curedump configuration additions
To: jakob@unthought.net (=?iso-8859-1?Q?Jakob_=D8stergaard?=)
Date: Sun, 6 May 2001 03:03:08 -0400 (EDT)
Cc: michaelm@mjmm.org (Michael Miller), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010505221808.C22425@unthought.net> from "=?iso-8859-1?Q?Jakob_=D8stergaard?=" at May 05, 2001 10:18:08 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?Jak writes:

> Hi, just wanted to recommend that this goes in, in one form or
> another  -  it would help a lot around here.

Yes, it looks very nice. The codes match those used by ps even.

> Today we have to manually "fix" the kernel
> source to get proper core.[executable] naming of core dumps.

That is just wrong. What about when "tar" dumps core?
It will overwrite my /usr/src/linux/net/core backup.
