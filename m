Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314701AbSDTSDP>; Sat, 20 Apr 2002 14:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSDTSCV>; Sat, 20 Apr 2002 14:02:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36435 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314677AbSDTSBC>; Sat, 20 Apr 2002 14:01:02 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16ya3u-0000RG-00@starship>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Apr 2002 11:53:11 -0600
Message-ID: <m1elha45q0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> Hi Linus,
> 
> I have up to this point been open to the use of Bitkeeper as a development
> aid for Linux, and, again up to this point, have intended to make use of 
> Bitkeeper myself, taking a pragmatic attitude towards the concept of using 
> the best tool for the job.  However, now I see that Bitkeeper documentation 
> has quietly been inserted ino the Linux Documentation directory, and that 
> without any apparent discussion on lkml.  I fear that this demonstrates that 
> those who have called the use of Bitkeeper a slippery slope do have a point 
> after all.

Daniel I agree that there are some real dangers to using a proprietary
tool, and have seen it severely affect a project.  

The primary problem is that some developers are not able to
participate because they do not have the tool. 

Given that bitkeeper is currently freely available, and that people
can still send raw patches I do not see that people are currently
being excluded on basis of the tool they use.

I can see the potential for this to break down.  However we should
not be crying wolf until this actually does break down.

There is exactly one point where religious attitudes are important.
Because of them some people will not use a non-free tool.  So for a
wide spread project there must be some way for them to participate.
diffs are still being accepted, so these people do have a to
participate.

Eric





