Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSBVJM0>; Fri, 22 Feb 2002 04:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSBVJMH>; Fri, 22 Feb 2002 04:12:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8715 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287493AbSBVJL7>;
	Fri, 22 Feb 2002 04:11:59 -0500
Date: Fri, 22 Feb 2002 10:04:53 +0100
From: Jens Axboe <axboe@suse.de>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: linux-2.5.5-dj1 + xfs-cvs --- kernel bug at elevator.c : 237!
Message-ID: <20020222090453.GI1427@suse.de>
In-Reply-To: <3C7607A7.2020804@st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7607A7.2020804@st-peter.stw.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22 2002, svetljo wrote:
> i tried to get patch-2.5.5dj1 in linux-2.5.5-xfs-cvs
> but thats what i got
> #####################################
> Activating swap partitions:        OK
> Finding modules dependancies:  OK
> Kernel Bug at elevator.c : 237!
> Invalid operand: 0000

known problem, disable ide floppy support for now.

-- 
Jens Axboe

