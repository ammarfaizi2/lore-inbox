Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWAFBYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWAFBYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWAFBYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:24:15 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:26754 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750835AbWAFBYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:24:14 -0500
Date: Thu, 5 Jan 2006 17:24:01 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Dave Jones <davej@redhat.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060105103339.GG20809@redhat.com>
Message-ID: <Pine.LNX.4.62.0601051722110.973@qynat.qvtvafvgr.pbz>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
 <20060105103339.GG20809@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Dave Jones wrote:

> > (*) If the oops is longer than 25 lines, ... you can't even use scrollback
> > because scrollback is cleared when you change consoles. X runs by default
> > on tty7, and the kernel dumps it somewhere else. (And even if it dumped to
> > tty7 directly, you would not see it.)
>
> What to do about oopses whilst in X has been the subject of much
> head-scratching for years now.  It's come up at least at the
> last two kernel summits, and I'll hazard a guess it'll come up
> again this year.  The amount of work necessary to make it all
> work on both kernel side and X side isn't unsubstantial however,
> so I wouldn't count on it working too soon.

hmm, if you can hope that someone will grab a camera to report an oops, 
how about them grabbing a tape recorder/mp3 recorder to record audio from 
the speaker. it's not fast, but you don't have that much data to output, 
do it in morse (with the audio explination of what's going to happen 
first)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

