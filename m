Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbTCVXMj>; Sat, 22 Mar 2003 18:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbTCVXMj>; Sat, 22 Mar 2003 18:12:39 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:1152 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261386AbTCVXMj>; Sat, 22 Mar 2003 18:12:39 -0500
Date: Sat, 22 Mar 2003 15:23:43 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.65] Broken gcc test
Message-ID: <20030322232343.GA2214@ip68-101-124-193.oc.oc.cox.net>
References: <20030321202034.GA3101@ip68-101-124-193.oc.oc.cox.net> <Pine.LNX.3.96.1030322072248.16653B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030322072248.16653B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 07:30:54AM -0500, Bill Davidsen wrote:
> So the choice is to use the 3.x compiler which has issues as well as
> generating slow code, or to not be able to generate a decent error report
> if something doesn't work right, rip the half-assed check out, or just use
> 2.4 kernels.

There's another option: gcc 2.95.[34].

-Barry K. Nathan <barryn@pobox.com>
