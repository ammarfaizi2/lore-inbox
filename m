Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJTD4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJTD4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270362AbUJTDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:51:50 -0400
Received: from mail.autoweb.net ([198.172.237.26]:35849 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S270523AbUJTDp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 23:45:58 -0400
Date: Tue, 19 Oct 2004 23:45:24 -0400
From: Ryan Anderson <ryan@michonline.com>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
Message-ID: <20041020034524.GD10638@michonline.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@drdos.com>,
	Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41757478.4090402@drdos.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 02:09:28PM -0600, Jeff V. Merkey wrote:
> XFS, JFS and NUMA are easy ones.

As I understand it, JFS was originally written for AIX.  The OS/2 team
at IBM rewrote it from scratch for OS/2.  Their version was cleaner, so
*that* got ported to AIX. (Maybe 5L, not really sure on versions here.)
The JFS for OS/2 is the predecessor to the Linux version.

Where's the Unix IP infection come from?

> RCU and NUMA are not.

RCU - originally a paper, implemented in Dynix and in other operating
systems from the paper (and patent), implemented in Linux as well.

Oh, and disclaimers:

IANAL, all knowledge gleaned from extensive reading, not personal
experience.  Feel free to flame me if I screwed something up.  (And I
apologize if I did so.)

-- 

Ryan Anderson
  sometimes Pug Majere
