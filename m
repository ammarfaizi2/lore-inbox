Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285460AbRLGL1t>; Fri, 7 Dec 2001 06:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285463AbRLGL1k>; Fri, 7 Dec 2001 06:27:40 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:29109 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S285455AbRLGL10>;
	Fri, 7 Dec 2001 06:27:26 -0500
Message-ID: <3C115125.E70E0674@sltnet.lk>
Date: Fri, 07 Dec 2001 17:30:45 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-lightening i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Fs's affected by smart atime updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everyone,
	I've found out that NTFS and FAT are not affected
adversely by the atime update patch by Andrew Morton.
(atime resolution in NTFS is 1 hour and in FAT, well, 
1 day!). I'd be thankful if anyone could point out
which filesystems, if any, are _adversely_ affected by this.

	Thanks.
		- ioj
