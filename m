Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSGBCIU>; Mon, 1 Jul 2002 22:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSGBCIT>; Mon, 1 Jul 2002 22:08:19 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:35017 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S316594AbSGBCIT>; Mon, 1 Jul 2002 22:08:19 -0400
Message-Id: <200207020217.g622HBAp001248@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 1 Jul 2002 22:17:10 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 : fs/intermezzo/psdev.c compile error
References: <Pine.LNX.4.44.0207011726210.860-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207011726210.860-100000@localhost.localdomain>; from fdavis@si.rr.com on Mon, Jul 01, 2002 at 05:31:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Davis wrote:
>    Does a patch exist for the following compile error? I thought that one 
> existed, but can't find one in the linux-kernel archives. If not, I can 
> work on one.

There have been various patches for Intermezzo posted but they have
fixed compile errors only and not made it work.  IIRC, the locking scheme
has never caught up to the 2.5 changes.  There are more problems than
just compile errors.

-- 
Skip
