Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRG1HlI>; Sat, 28 Jul 2001 03:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRG1Hk5>; Sat, 28 Jul 2001 03:40:57 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17423 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266488AbRG1Hks>; Sat, 28 Jul 2001 03:40:48 -0400
Message-ID: <3B626C38.839ED912@namesys.com>
Date: Sat, 28 Jul 2001 11:39:36 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel <linux-kernel@vger.kernel.org>,
        "Gryaznova E." <grev@namesys.botik.ru>, Chris Mason <mason@suse.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107280816200.23742-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

bvermeul@devel.blackstar.nl wrote:
> 
> > You should not see old data being corrupted.  If you are seeing it with
> > a recent ReiserFS version,
> > we'd like your help in reproducing it.
> 
> It is not old data perse. I edited those files. They have been opened, and
> written back. But it will shuffle every bit of data in those files, and
> I'll find sourcecode in the object file, *.d files, etc. The source file
> itself is mostly garbled as well.
> 
> I can see if I can come up with a module as simple as possible to
> reproduce this. (This is still a while(1); in kernel essentially, with
> a couple of seconds between the hang and the compile/install cycle)
> 
> If you're interested, let me know, and I'll see if I can make a test-case
> for you.
> 
> Bas Vermeulen
> 
> --
> "God, root, what is difference?"
>         -- Pitr, User Friendly
> 
> "God is more forgiving."
>         -- Dave Aronson
I am very much interested in a test case.

hans
