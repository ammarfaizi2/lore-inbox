Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273998AbRIXVwR>; Mon, 24 Sep 2001 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274159AbRIXVwI>; Mon, 24 Sep 2001 17:52:08 -0400
Received: from pblx.net ([64.167.128.182]:39684 "HELO dobie.pblx.net")
	by vger.kernel.org with SMTP id <S274126AbRIXVvv>;
	Mon, 24 Sep 2001 17:51:51 -0400
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 24 Sep 2001 14:52:16 -0700 (PDT)
From: shewp <shewp@pblx.net>
To: linux-kernel@vger.kernel.org
Subject: broken /proc/partitions
Message-Id: <20010924215200Z274126-761+12379@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did anyone notice that cat /proc/partitions on 2.4.10 loops 
infinitely?

it makes dump loop too, which is how i found out.

thanks


