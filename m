Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270988AbUJUVcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbUJUVcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270990AbUJUV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:29:04 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23004 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270836AbUJUV1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:27:54 -0400
Subject: Re: Proposal: Desktop kernel bk tree/patchset.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <417780CB.4060106@yahoo.com.au>
References: <1098344977.4146.21.camel@desktop.cunninghams>
	 <417780CB.4060106@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1098393711.4146.35.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Oct 2004 07:21:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-10-21 at 19:26, Nick Piggin wrote:
> I don't think it would be a really good idea to have an official tree
> for desktop users. A staging area for desktop improvements, sure that
> would be no problem. But if you really have some good improvements,
> they should eventually get into the mainline kernel where you can
> expect a pretty good (or not terribly bad) review and testing process.

Yeah; I'm thinking more a staging area where people who use Linux for
desktop work (as I do) can bang on the PM support and other enhancements
they'd be after. Not an end in itself.

> On the other hand, I understand you're probably frustrated at the slow
> pace and politics of getting more ambitious patches into the kernel.

Actually, I'm not at all. The slowness in merging suspend2 has so far
been because I've been putting lots of work into trying to get
everything neater and tidier, so I only have myself to blame there :>.
I'm hoping to begin another round of posting patches shortly, hopefully
this time including the substance of the patches.

> I'd go for angle of aiming to get things into -mm. Andrew generally
> doesn't mind brewing things up there, even if there is no clear path
> for merging into 2.6 at the time... so long as they're pretty stable
> and not going to cause rejects all over the tree, of course.

Yes, I'm aiming for -mm. Stability isn't a problem, and it touches a lot
less of the tree than it used to: the main changes now are refrigerator
improvements and hooks.

> Just my two cents.

Appreciated!

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

