Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRGNQXG>; Sat, 14 Jul 2001 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGNQW5>; Sat, 14 Jul 2001 12:22:57 -0400
Received: from geos.coastside.net ([207.213.212.4]:30165 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262389AbRGNQWj>; Sat, 14 Jul 2001 12:22:39 -0400
Mime-Version: 1.0
Message-Id: <p05100305b7761878d7b1@[207.213.214.37]>
In-Reply-To: <20010715025001.B6722@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
 <20010715025001.B6722@weta.f00f.org>
Date: Sat, 14 Jul 2001 08:41:52 -0700
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:50 AM +1200 2001-07-15, Chris Wedgwood wrote:
>On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:
>
>     As far as I can tell none of them at least in the IDE world
>
>SCSI disk must, or at least some... if not, how to peopel like NetApp
>get these cool HA certifications?

NetApp uses a large system-local NVRAM buffer, do they not?
-- 
/Jonathan Lundell.
