Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283975AbRLAH1S>; Sat, 1 Dec 2001 02:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283977AbRLAH1I>; Sat, 1 Dec 2001 02:27:08 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:10513
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S283975AbRLAH06>; Sat, 1 Dec 2001 02:26:58 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200112010703.fB1731403709@www.hockin.org>
Subject: Re: Coding style - a non-issue
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Nov 2001 23:03:01 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:43 PM 11/30/01 -0800, Stephen Satchell wrote:

> Most of the bad-but-not-obviously-bad ideas get rooted out by people trying
> them and finding them to be wanting.  Take, for example, the VM flap in the
>
Ahh right, like the OOM killer.  There's a brilliant idea that got rooted
out to where it belongs...

> The "Linux Way" as I understand it is to release early and release
> often.  That means that we go through a "generation" of released code every

And disregard the "mutations" that have already been "selected for" (to
carry the analogy) in other systems.  And disregard any edge-case that is
"too hard" or "too rare" or "involves serious testing".

> Now that I've stretched the analogy as far as I care to, I will stop
> now.  Please consider the life-cycle of the kernel when thinking about what
> Linus said.

I can't consider joe.random developer adding a feature as a "mutation".
It's just not analogous in my mind.

