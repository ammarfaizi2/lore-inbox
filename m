Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbSJHDTO>; Mon, 7 Oct 2002 23:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSJHDTO>; Mon, 7 Oct 2002 23:19:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:15276 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262745AbSJHDTO>; Mon, 7 Oct 2002 23:19:14 -0400
Date: Mon, 07 Oct 2002 20:04:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: *Wierd* system.map with 2.5.40-mm2
Message-ID: <1409688855.1034021059@[10.10.2.3]>
In-Reply-To: <1408802210.1034020172@[10.10.2.3]>
References: <1408802210.1034020172@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, something really strange is going on. If I take the exact 
> same config file, and compile it with 2.5.40-mm1 and 2.5.40-mm2,
> the former works fine, the latter produces wierd borkedness for
> System.map (though it appears to boot & run just fine). This 
> makes it very hard to do any profiling or oops tracing.
> 
> What the heck happened? I didn't reconfig for a 2/2 split or
> anything ... me confused. config file attatched.

This doesn't happen with 2.5.41 ... so either it's in the -mm
extra stuff somewhere, or it was in the BK snapshot you pulled,
but fixed again before 2.5.41?

M.

