Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTGBEx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbTGBEx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:53:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5577 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264695AbTGBEx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:53:56 -0400
Date: Tue, 01 Jul 2003 22:07:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-ID: <15570000.1057122469@[10.10.2.4]>
In-Reply-To: <20030701203830.19ba9328.akpm@digeo.com>
References: <20030701203830.19ba9328.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@digeo.com> wrote (on Tuesday, July 01, 2003 20:38:30 -0700):

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/

;-(

VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

mm2 works fine.

Seems like no SCSI drivers at all got loaded ... same config file,
feral on ISP.

M.

