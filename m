Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277530AbRJERvu>; Fri, 5 Oct 2001 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277536AbRJERvk>; Fri, 5 Oct 2001 13:51:40 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:10444 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277527AbRJERve>; Fri, 5 Oct 2001 13:51:34 -0400
Date: Fri, 5 Oct 2001 23:27:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11pre3aa1
Message-ID: <20011005232735.A23554@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011004225708.A724@athlon.random> Andrea Arcangeli wrote:
> FYI: the next things I will try to concentrate on the next days are:

> 4) rcu, Dipankar, could you send me your latest version, the design that we
>    agreed that only adds a per-cpu sequence number inc (not a branch)
>    in schedule?

The latest patch based on our agreed design (2.4.10) is available at -
http://lse.sourceforge.net/locking/patches/rcu-2.4.10-1.patch

I will make a 2.4.11preX patch as soon as I can get to that.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
