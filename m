Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288647AbSADTRC>; Fri, 4 Jan 2002 14:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284580AbSADTQw>; Fri, 4 Jan 2002 14:16:52 -0500
Received: from marine.sonic.net ([208.201.224.37]:17008 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S288712AbSADTQk>;
	Fri, 4 Jan 2002 14:16:40 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 4 Jan 2002 11:16:32 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
Message-ID: <20020104191632.GK28621@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200201041831.g04IVAD23320@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.33.0201041940150.20620-100000@Appserv.suse.de> <200201041841.g04IflL23687@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201041841.g04IflL23687@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 11:41:47AM -0700, Richard Gooch wrote:
> Not if you want a lightweight C library. Such as when running off a CF
> card.

But aren't there better options for a lightweight C library than libc5?

At least that would involve using something that's being maintained.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
