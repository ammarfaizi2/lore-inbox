Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTL2BIF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTL2BIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:08:05 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:22657
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262164AbTL2BID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:08:03 -0500
Date: Sun, 28 Dec 2003 20:18:19 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031228201819.A2276@animx.eu.org>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu> <20031228213535.GA21459@mail-infomine.ucr.edu> <1072647938.10298.3.camel@laptop.fenrus.com> <bsnnj9$lkf$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <bsnnj9$lkf$1@cesium.transmeta.com>; from H. Peter Anvin on Sun, Dec 28, 2003 at 03:05:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not to mention, well, *proprietary*.  Consider this: with Linux
> swraid, you don't have to worry about your manufacturer discontinuing
> your product or going out of business; as long as you can connect your
> disks to a CPU using any kind of controller you can recover your
> data.  If a proprietary RAID controller croaks, and you can't get
> another one of the same brand/model, you might have no more data...

Speaking of which, since most DIE^WIDE RAID controllers are really software
driven, it may be possible to get the sw module to read the disks off of any
controller

My machine at work has an onboard promise raid controller but I run linux sw
raid0 on 2 of the disks (4 total, other 2 are not in a raid)

I'm not sure about real hardware raid.  Like the Mylex or Adaptec (SCSI)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
