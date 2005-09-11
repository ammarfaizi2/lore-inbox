Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVIKHU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVIKHU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVIKHU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:20:28 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:17900 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932436AbVIKHU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:20:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Sun, 11 Sep 2005 00:20:06 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13 
In-Reply-To: <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
 <20050911030726.GA20462@suse.de><Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
 <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 10 Sep 2005 23:08:36 PDT, David Lang said:
>
>> remember that the distros don't package every kernel, they skip several
>> between releases and it's not going to be until they go to try them that
>> all the kinks will get worked out.
>
> I'll bite - what distros are shipping a kernel 2.6.10 or later and still
> using devfs?
>
I'll admit I don't keep track of the distros and what kernels and features 
they are useing. I think I've heard people mention gentoo, but I 
haven't verified this.

however with the thousands of linux distros out there I'd lay odds that 
_someone_ is doing it ;-)

That said, my comments about the schedule should apply to any significant 
feature, not just devfs, it just happens to be the current patch being 
discussed. If Greg hadn't asked me how long I thought he needed to wait I 
would have dropped out after my initial post, but he asked so I answered.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
