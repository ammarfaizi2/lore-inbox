Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288191AbSACENm>; Wed, 2 Jan 2002 23:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288192AbSACENd>; Wed, 2 Jan 2002 23:13:33 -0500
Received: from ns.suse.de ([213.95.15.193]:47108 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288191AbSACENR>;
	Wed, 2 Jan 2002 23:13:17 -0500
Date: Thu, 3 Jan 2002 05:13:15 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: Art Hays <art@lsr.nei.nih.gov>, <linux-kernel@vger.kernel.org>
Subject: RE: kswapd etc hogging machine
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBAECPEFAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.33.0201030510160.6449-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, M. Edward Borasky wrote:

> There were a whole bunch of tuning parameters in the VM in 2.2 that got
> dropped in 2.4; maybe re-instating some of them and returning them to their
> rightful owner, the system administrator, would solve this problem once and
> for all. But for some reason, those who control Linux have decided that this
> is "a bug in the VM" and pursued fixes in code and the associated logic
> rather than give us sysadmins what I believe is rightfully ours.

Extra magic number twiddling is available in Andrea's -aa tree.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

