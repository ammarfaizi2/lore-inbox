Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSIYRpU>; Wed, 25 Sep 2002 13:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSIYRpU>; Wed, 25 Sep 2002 13:45:20 -0400
Received: from henreid.umail.ucsb.edu ([128.111.151.215]:4362 "EHLO
	henreid.umail.ucsb.edu") by vger.kernel.org with ESMTP
	id <S262038AbSIYRpT>; Wed, 25 Sep 2002 13:45:19 -0400
Message-ID: <1032976231.3d91f767c71a4@webaccess.umail.ucsb.edu>
Date: Wed, 25 Sep 2002 10:50:31 -0700
From: Lingli Zhang <lingli_z@umail.ucsb.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: mmap() failed on Linux 2.4.18-10smp with 4GB RAM
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1.1-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot to those who replied to me. Big help!

Now my question is how do I know where linux puts kernel in the memory?
What address is safe to mmap a big chunk?Is there a way to force it to be a
specific address? 

Best Regards!

Lingli

-- 
Lingli Zhang
lingli_z@umail.ucsb.edu
