Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTBQS3I>; Mon, 17 Feb 2003 13:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTBQS3H>; Mon, 17 Feb 2003 13:29:07 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55971 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267388AbTBQS2U>; Mon, 17 Feb 2003 13:28:20 -0500
Date: Mon, 17 Feb 2003 19:38:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bourne <jbourne@mtroyal.ab.ca>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <20030217183818.GA26916@wohnheim.fh-wedel.de>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]> <20030217170851.GA18693@wohnheim.fh-wedel.de> <9850000.1045504008@[10.10.2.4]> <20030217183113.GA24922@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030217183113.GA24922@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 February 2003 19:31:13 +0100, Jörn Engel wrote:
> 
> You appear to not have /etc/mtab as a symlink to /proc/mounts. One of
> the first things I do on fresh debian installations. The kernel should
> know better than some file, especially when / is mounted ro.
> 
> My broken memory tells me that Debian is working quite fine. The code
> in question should be in /etc/init.d/checkroot.sh in your system.

My stupid mind should have trusted the eye and made that connection
itself. Thanks for pointing it out.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
