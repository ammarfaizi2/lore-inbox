Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130751AbQLRVWq>; Mon, 18 Dec 2000 16:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130584AbQLRVWg>; Mon, 18 Dec 2000 16:22:36 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:58382 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129930AbQLRVW3>;
	Mon, 18 Dec 2000 16:22:29 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012182051.eBIKphZ508751@saturn.cs.uml.edu>
Subject: Re: taskfs and kernfs
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 18 Dec 2000 15:51:43 -0500 (EST)
Cc: dave@thor.sbay.org (Dave Zarzycki), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0011051441240.25503-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 05, 2000 02:48:03 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Sun, 5 Nov 2000, Dave Zarzycki wrote:
>> On Sun, 5 Nov 2000, Alexander Viro wrote:
>>
>>> However, kernfs is _not_ procfs \setminus procfs-proper. It's our current
>>> /proc/sys.
>>
>> Okay. I didn't realize that's what you had in mind when you wrote
>> "kernfs." Mind if I ask why you didn't call it "sysctlfs" or "sysfs?"
>
> Check *BSD.

Meanwhile, the FreeBSD people seem to be about to junk kernfs.
One is supposed to use sysctl. (freebsd-hackers or freebsd-arch
just this week)

I didn't know penguins went dumpster diving in Satan's trash.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
