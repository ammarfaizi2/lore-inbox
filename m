Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbRFXFQj>; Sun, 24 Jun 2001 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263605AbRFXFQ3>; Sun, 24 Jun 2001 01:16:29 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:17418 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S263597AbRFXFQN>; Sun, 24 Jun 2001 01:16:13 -0400
Date: Sun, 24 Jun 2001 13:16:46 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: replay on read-only filesystem
Message-ID: <Pine.LNX.4.33.0106241313470.982-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what's the impact of mounting reiserfs as Read-Only (specified in fstab)?

>From syslog ...

Jun 24 01:10:30 boston kernel: Warning, log replay starting on readonly
filesystem


Is this a problem?


Thanks,
Jeff
[ jchua@fedex.com ]

