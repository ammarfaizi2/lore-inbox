Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRHDPiz>; Sat, 4 Aug 2001 11:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268909AbRHDPir>; Sat, 4 Aug 2001 11:38:47 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:22443 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268813AbRHDPig>; Sat, 4 Aug 2001 11:38:36 -0400
Date: Sat, 4 Aug 2001 11:38:41 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac4 disk thrashing
Message-ID: <20010804113841.A2196@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

switching from 2.4.7-ac3 to -ac4, disk access seems to be much more
synchronis. running a ./configure script causes all kinds of trashing, as
does installing .debs. i'm using reiserfs on top of software raid 0 on an
alpha.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
