Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270644AbRHNSlD>; Tue, 14 Aug 2001 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270632AbRHNSky>; Tue, 14 Aug 2001 14:40:54 -0400
Received: from www.casdn.neu.edu ([155.33.251.101]:4370 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S270644AbRHNSka>; Tue, 14 Aug 2001 14:40:30 -0400
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 14 Aug 2001 09:58:32 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Are we going too fast?
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3B78F648.14074.58721CD@localhost>
In-Reply-To: <3B776EA5000338FD@mta3n.bluewin.ch> (added by postmaster@bluewin.ch)
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 2001, at 20:46, Per Jessen wrote:

> >On Mon, 13 Aug 2001 14:11:32 +0100 (BST), Alan Cox wrote:
> >
> >If you want maximum stability you want to be running 2.2 or even 2.0. Newer
> >less tested code is always less table. 2.4 wont be as stable as 2.2 for a
> >year yet.
> 
> Couldn't have put that any better. On mission-critical systems, this is
> exactly what people do. Personally, my experience is from the big-iron
> world of S390 -  if you're a bleeding-edge organisation, you'll be out
> there applying the latest PTFs, you'll be running the latest OS/390 etc. 
> If you're conservative, you're at least 2, maybe 3 releases (in todays 
> OS390 this means about 18-24 months) behind. If you're ultra-conservative,
> you'll wait for the point where you can no longer avoid an upgrade.

We've only just now moved from 2.0.36 to 2.2.18, and cautiously at 
that. We've started to run into applications that won't run on the 
older kernel/lib combinatons that we need.


                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/
