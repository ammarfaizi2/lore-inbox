Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282956AbRLDV6U>; Tue, 4 Dec 2001 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283537AbRLDV6K>; Tue, 4 Dec 2001 16:58:10 -0500
Received: from marine.sonic.net ([208.201.224.37]:17776 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S283534AbRLDV54>;
	Tue, 4 Dec 2001 16:57:56 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 4 Dec 2001 13:57:48 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Roland Bauerschmidt <rb@debian.org>
Subject: Re: virtual filesystem with data managed in userspace
Message-ID: <20011204135748.F1348@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Roland Bauerschmidt <rb@debian.org>
In-Reply-To: <20011204224026.A18753@g>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204224026.A18753@g>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 10:40:26PM +0100, Roland Bauerschmidt wrote:
> Do you think this concept is workable at all? What I am most worried

Workable, and done.  Several times over.

The old userfs stuff, for instance.

Any number of NFSD and the ilk (the Berkeley automount daemon, amd, for
instance, could do this kind of stuff it wanted to).

I believe CODA plays that game as well (at least to some extent).

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
