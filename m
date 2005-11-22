Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVKVQPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVKVQPC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVKVQPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:15:01 -0500
Received: from xenotime.net ([66.160.160.81]:64911 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964975AbVKVQPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:15:01 -0500
Date: Tue, 22 Nov 2005 08:14:57 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Bill Davidsen <davidsen@tmr.com>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <43834098.60400@tmr.com>
Message-ID: <Pine.LNX.4.58.0511220814290.30423@shark.he.net>
References: <E1EeLp5-0002fZ-00@calista.inka.de> <43825168.6050404@wolfmountaingroup.com>
 <43834098.60400@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Bill Davidsen wrote:

> Jeff V. Merkey wrote:
> > Bernd Eckenfels wrote:
> >
> >> In article <200511211252.04217.rob@landley.net> you wrote:
> >>
> >>
> >>> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.
> >>> Python says 2**64 is 18446744073709551616, and that's roughly:
> >>> 18,446,744,073,709,551,616 bytes
> >>> 18,446,744,073,709 megs
> >>> 18,446,744,073 gigs
> >>> 18,446,744 terabytes
> >>> 18,446 ...  what are those, pedabytes (petabytes?)
> >>> 18          zetabytes
> >>>
> > There you go.  I deal with this a lot so, those are the names.
> >
> > Linux is currently limited to 16 TB per VFS mount point, it's all mute,
> > unless VFS gets fixed.
> > mmap won't go above this at present.
> >
> What does "it's all mute" mean?

It means "it's all moot."

-- 
~Randy
