Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTA0L0f>; Mon, 27 Jan 2003 06:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTA0L0f>; Mon, 27 Jan 2003 06:26:35 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33546
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267163AbTA0L0e>; Mon, 27 Jan 2003 06:26:34 -0500
Date: Mon, 27 Jan 2003 03:30:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Balbir Singh <balbir_soni@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Patches have a license
In-Reply-To: <20030127104705.GC25913@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.10.10301270326270.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Dave Jones wrote:

> On Mon, Jan 27, 2003 at 01:58:40AM -0800, Balbir Singh wrote:
>  > I would request everyone to post their patches with
>  > a license, failing which it should be assumed that
>  > the license is GPL.
> 
> Surely the license of the diff matches the license of the
> code it is patching ?  

NO!

Insert a random amount of comments or linefeeds and hand edit the patch to
conform on a --dry-run and it does not mate.

Remember "patch" is only a series of offsets and comparison.
There is no checksum against the file to be patched.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

