Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSEUWNj>; Tue, 21 May 2002 18:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316692AbSEUWNi>; Tue, 21 May 2002 18:13:38 -0400
Received: from web20806.mail.yahoo.com ([216.136.226.195]:6672 "HELO
	web20806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316746AbSEUWNh>; Tue, 21 May 2002 18:13:37 -0400
Message-ID: <20020521221337.32519.qmail@web20806.mail.yahoo.com>
Date: Tue, 21 May 2002 15:13:37 -0700 (PDT)
From: Shane Walton <dsrelist@yahoo.com>
Subject: MTRR HyperThread cache Conflict
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few dual Xeon machines and have enabled
hyperthreading with 2.4.17.  If MTRR is enable and you
start X, we get a CPU cache conflict that will not
release until rebooted.  It appears that the cache is
being thrashed continuously, and the loading is
terrible.  

We have seen discussions of several patches regarding
this problem.  However, we have not found which base
kernel version has the patch applied.  Is this patch
in the 2.4.18 or 2.4.19 pre-release?  Thanks.

Regards,


=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
