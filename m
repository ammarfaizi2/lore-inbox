Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSEaDku>; Thu, 30 May 2002 23:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSEaDku>; Thu, 30 May 2002 23:40:50 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:49887 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314546AbSEaDkt>;
	Thu, 30 May 2002 23:40:49 -0400
Content-Type: text/plain;
  charset="gb2312"
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Hua Zhong" <hzhong@cisco.com>, "Kenneth Johansson" <ken@canit.se>
Subject: Re: KBuild 2.5 Impressions
Date: Fri, 31 May 2002 05:39:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Keith Owens" <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <FEEFKBEFIEBONNKJABKDOEIKDKAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17DdG5-0007k7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 05:29, Hua Zhong wrote:
> Auh..the "only Keith could fix things"....come'on, isn't this open-source?
> Hey, You guys are genius,
> and I don't believe at all a build system is more complex than any piece of
> the kernel itself. And look at
> the VM change during 2.4 (sorry to mention it again), how about "only Andrea
> could fix bugs in the new
> VM"? That still happened, although there was far less documentation of the
> new VM than that of kbuild 2.5.

Funny you should mention that, since I just this minute completed a small
hack for the benefit of Andrew Morton, who likes to be able to have his
.config as a symlink.  Yes it was easy, even starting from a state of
nearly complete cluelessness.  And before anybody asks, no I did not do the
job properly, I do not pretend or want to be a member of the kbuild team.
I just wanted to know how hard it is to hack this thing.

-- 
Daniel
