Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTAMM0E>; Mon, 13 Jan 2003 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTAMM0E>; Mon, 13 Jan 2003 07:26:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4749 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267859AbTAMM0D>;
	Mon, 13 Jan 2003 07:26:03 -0500
Date: Mon, 13 Jan 2003 12:32:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on kernel config organization
Message-ID: <20030113123243.GC9031@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:17:46PM -0500, Robert P. J. Day wrote:

 >   starting at what seems to be a pretty arbitrary choice
 > (quota support?  how did that end up at the top of the list?),
 > we then get "automounter" (again, a bit premature, it seems),
 > then reiserfs(??), and a bunch of experimental filesystems
 > before getting to ext3, which doesn't really flow well.
 >   then we jump to DOS filesystems, bounce around a bit more,
 > on to JFS (why is this not next to reiserfs?), etc, etc.
 > and, near that bottom of the list, ext2??

At one point I'm sure it was alphabetically ordered.
As time as gone on, it's turned into arbitary placement..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
