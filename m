Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbTLRTpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTLRTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:45:54 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:52190 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265294AbTLRTpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:45:53 -0500
Date: Thu, 18 Dec 2003 11:45:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: MD Raid fixed? was: Linux 2.6.0
Message-ID: <20031218194537.GF6438@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org> <20031217211516.2c578bab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217211516.2c578bab.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 09:15:16PM -0800, Andrew Morton wrote:
> - There are significant changes in the module subsystem, the LVM (Device
>   Mapper) and RAID subsystems.  Details about these and many other kernel

There was a thread against 2.6.test11 about some issues with MD & DM.  Also
there was one report of problems with ext3+MD.

I don't use LVM or DM, so I'm interested in the second case.

Thanks
