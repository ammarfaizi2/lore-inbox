Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbRDWC1c>; Sun, 22 Apr 2001 22:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136340AbRDWC1W>; Sun, 22 Apr 2001 22:27:22 -0400
Received: from leng.mclure.org ([64.81.48.142]:2056 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136339AbRDWC1G>; Sun, 22 Apr 2001 22:27:06 -0400
Date: Sun, 22 Apr 2001 19:27:04 -0700
From: Manuel McLure <manuel@mclure.org>
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on multi-threaded X process crash
Message-ID: <20010422192704.C3618@ulthar.internal.mclure.org>
In-Reply-To: <20010422185514.A981@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010422185514.A981@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Apr 22, 2001 at 18:55:14 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 18:55 Manuel McLure wrote:

> The machine is an Athlon Thunderbird 900MHz with 256M of PC133 DRAM on an
> MSI K7T Turbo R motherboard. I am running 2.4.3-ac12 currently,
> 2.4.3-ac11
> and 2.4.3-ac5 hung the same way at least once each before I started
> tracking this down. I am running Red Hat 7.1, and am using the
> XFree86-4.0.3 RPMs that come with RH71 with the CVS DRI trunk installed
> over it. The kernel was built with kgcc, a gcc-2.96 built kernel has the
> same problem.

Following up on myself, I replaced the contents of /usr/X11R6 server with
the standard 4.0.3 RPMs that come with RH 7.1 and it made no difference.
Also, if it's important my video card is a Voodoo 5 5500.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

