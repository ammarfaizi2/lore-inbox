Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313065AbSC3P0M>; Sat, 30 Mar 2002 10:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313472AbSC3P0C>; Sat, 30 Mar 2002 10:26:02 -0500
Received: from dialin-145-254-150-087.arcor-ip.net ([145.254.150.87]:17668
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S313065AbSC3PZt>; Sat, 30 Mar 2002 10:25:49 -0500
Message-ID: <3CA5D82E.470633C3@loewe-komp.de>
Date: Sat, 30 Mar 2002 16:22:22 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Keith Owens <kaos@ocs.com.au>, Jeremy Jackson <jerj@coplanar.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"?
In-Reply-To: Your message of "Fri, 29 Mar 2002 19:18:39 -0800." <3CA53DE5.668AC7AB@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I would like to see kdb shipped in the mainline kernel, so that
> we can get better diagnostic reports from users/testers.
> 

Whoops, I think the same. And also something like a crash dump
utility would be nice in the mainline kernels.

Without them it's hard to get qualified bug reports from
production machines...
