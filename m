Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRJ3NTs>; Tue, 30 Oct 2001 08:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRJ3NT2>; Tue, 30 Oct 2001 08:19:28 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:29158 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S275983AbRJ3NTZ>; Tue, 30 Oct 2001 08:19:25 -0500
Date: Tue, 30 Oct 2001 08:35:36 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Andrew Ebling <andrew_ebling@tao-group.com>
cc: "ftpadmin@kernel.org" <ftpadmin@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.4.11-dontuse packages
In-Reply-To: <1004445089.485.17.camel@spinel>
Message-ID: <Pine.LNX.4.40.0110300824100.114-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Oct 2001, Andrew Ebling wrote:

> (Really for ftpadmin@kernel.org but CC'd to lkml for discussion
> purposes.)

I believe it was Linus that made the name change.

[Snip]

> Of course, I could put an ugly work around in the script for 2.4.11, but
> keeping the standard naming convention would be a better solution.  I do
> plan to warn users if they use the script to request kernel version
> 2.4.11, but unfortunately, use of the 2.4.11 patch is neccessary to get
> to 2.4.12 and above.

So you are already coding a special case in for 2.4.11 to give them the
warning.  Might as well take that special case and extend it to selecting
for file from the server.

I have a feeling the majority of the people browsing the kernel.org will
not be using your software.  It is probally best that the warning stays in
place for everyone, just so that kernel is avoided.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


