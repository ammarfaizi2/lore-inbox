Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315452AbSELXdO>; Sun, 12 May 2002 19:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSELXdN>; Sun, 12 May 2002 19:33:13 -0400
Received: from air-2.osdl.org ([65.201.151.6]:6149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315452AbSELXdM>;
	Sun, 12 May 2002 19:33:12 -0400
Date: Sun, 12 May 2002 16:32:00 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Pawel Kot <pkot@linuxnews.pl>
cc: John Weber <john.weber@linuxhq.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Unofficial but Supported Kernel Patches
In-Reply-To: <Pine.LNX.4.33.0205121858570.493-100000@urtica.linuxnews.pl>
Message-ID: <Pine.LNX.4.33L2.0205121625210.18473-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Pawel Kot wrote:

| On Sun, 12 May 2002, John Weber wrote:
|
| > I am trying to put a list together of all the unofficial kernel patches.
| >   I am speaking of systems like Rik's RMAP VM, and others like it.
| >
| > I want to put up a page on linuxhq.com with all of these patches.  If
| > you would like to have your maintained patches (or trees) listed, please
| > shoot me an email with a description of your tree (or patch) and what is
| > so special about it :).  Also include URLs, emails, or anything else
| > you'd like published.
|
| What about http://kernelnewbies.org/patches/ ?

That's nice.

What I would like is for someone to maintain a set of
"required" patches to each new kernel --
"required" here meaning "these patches are needed for kernel
x.y.z to build or boot cleanly."

The patchsets would contain only compile/link fixes and
critical logic fixes to release and pre-release kernels.

This wouldn't be for me necessarily, as I already keep a
"fixes" email file, but I think that this could help
cut down on repeated emails on lkml about <2.5.19 has errors>
or "mounting a CD with ide-scsi crashes 2.5.11."

It could help developers, users, and testers get going
quickly.

-- 
~Randy

