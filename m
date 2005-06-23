Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVFWGSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVFWGSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVFWGRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:17:30 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:19088 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262224AbVFWGOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:14:19 -0400
To: Greg KH <greg@kroah.com>
Cc: Mike Bell <kernel@mikebell.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
	<20050623010031.GB17453@mikebell.org>
	<20050623045959.GB10386@kroah.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 23 Jun 2005 15:14:08 +0900
In-Reply-To: <20050623045959.GB10386@kroah.com> (Greg KH's message of "Wed, 22 Jun 2005 21:59:59 -0700")
Message-Id: <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> And again, for embedded systems, there are packages to build it and put
> it in initramfs.  People have already done the work for you.

BTW, has anyone done a comparison of the space usage of udev vs. devfs
(including size of code etc....)?

Thanks,

-Miles
-- 
Run away!  Run away!
