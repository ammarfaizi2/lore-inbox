Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282092AbRLGPME>; Fri, 7 Dec 2001 10:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRLGPLr>; Fri, 7 Dec 2001 10:11:47 -0500
Received: from unknown.Level3.net ([63.210.233.154]:26893 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S282092AbRLGPKw>; Fri, 7 Dec 2001 10:10:52 -0500
Message-ID: <35F52ABC3317D511A55300D0B73EB8056FCCA9@cinshrexc01.shermfin.com>
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Memory cache hit-miss patch
Date: Fri, 7 Dec 2001 10:10:48 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been searching for a way to determine the memory cache hit ratio in
Linux and I came across a hitmiss patch for the 2.2 series that displays
some information in /proc/stat:

http://groups.google.com/groups?q=hitmiss+patch&hl=en&rnum=1&selm=1998072200
4516.G574%40msu.edu

My question is, how difficult would it be for this patch to be modified for
the 2.4 kernel?  If it is not that difficult could some one point me in the
right direction in the code to modify the patch to work with 2.4.

Thanks for your help,
Andy.


Andrew Rechenberg
Network Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com
