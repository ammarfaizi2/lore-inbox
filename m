Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUEJT61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUEJT61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUEJT60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:58:26 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:39656 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261439AbUEJT6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:58:18 -0400
From: celestar@t-online.de (Frank Victor Fischer)
To: linux-raid@vger.kernel.org
Subject: Re: RAID5 (along with RAID1) locks up
Date: Mon, 10 May 2004 21:58:04 +0200
User-Agent: KMail/1.6.2
References: <200405101351.i4ADpYB03061@www.watkins-home.com>
In-Reply-To: <200405101351.i4ADpYB03061@www.watkins-home.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405102158.04419.celestar@t-online.de>
X-Seen: false
X-ID: TJ+ROMZege6ReRKwST0vW8BpVyYaX69t+oOzgGhY2mA2mipAOyFKQJ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see your RAID1 (md0) using sda1, sdb1 and sdc1.
> Which disks/partitions is your RAID5 using?

Whoops that log was created before I re-created the RAID5

it was md1, using sda3, sdb3 and sdc3, each using up the rest of the drive.

Victor
