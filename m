Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274856AbRIUWHI>; Fri, 21 Sep 2001 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274855AbRIUWG6>; Fri, 21 Sep 2001 18:06:58 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:6926 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274854AbRIUWGx>; Fri, 21 Sep 2001 18:06:53 -0400
Date: Fri, 21 Sep 2001 18:07:17 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010921180717.L8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921170828.J8188@mueller.datastacks.com> <3BABB42A.6D17F44E@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BABB42A.6D17F44E@osdlab.org>; from rddunlap@osdlab.org on Fri, Sep 21, 2001 at 02:42:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 21/09/01 14:42 -0700 - Randy.Dunlap:
> Crutcher Dunnavant wrote:
> I've posted a patch (and copied you on it).
> It's in 2.4.9-ac13.
> You are welcome to post patches anyway, of course.

I've looked at that, and I really think that the commingling of the
loglevel settings is just wrong. The patch I just threw up is much
simpler, and does everthing needed.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
