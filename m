Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130950AbRCJHHK>; Sat, 10 Mar 2001 02:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130952AbRCJHGv>; Sat, 10 Mar 2001 02:06:51 -0500
Received: from [212.17.18.2] ([212.17.18.2]:520 "EHLO technoart.net")
	by vger.kernel.org with ESMTP id <S130950AbRCJHGp>;
	Sat, 10 Mar 2001 02:06:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: O_DSYNC flag for open
Date: Sat, 10 Mar 2001 13:03:57 +0600
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Message-Id: <01031013035702.00608@dyp.perchine.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

one small question... Will O_DSYNC flag be available in Linux?
It is available at least on AIX, and HP-UX. The difference with O_SYNC is the 
same as between fsync and fdatasync.

Any comments?

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
