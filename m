Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285046AbRLKPHg>; Tue, 11 Dec 2001 10:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285056AbRLKPH1>; Tue, 11 Dec 2001 10:07:27 -0500
Received: from demokritos.cytanet.com.cy ([195.14.133.252]:3085 "EHLO
	demokritos.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S285054AbRLKPHO>; Tue, 11 Dec 2001 10:07:14 -0500
From: Sinisa Milivojevic <sinisa@mysql.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15382.8806.167316.426217@sinisa.nasamreza.org>
Date: Tue, 11 Dec 2001 17:12:38 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 and gcc 3.0.2
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Reply-To: sinisa@mysql.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry to bother you again and please CC: the answer directly to me.

I have built 2.4.16 with 3.0.2 and when kernel reboots, it gets
segmentation violation at this command in init file:

swapon -a

I have used latest util-linux and rebuilt all programs, but to no
avail.

Should I comment out that line ??

Many thanks in advance.

-- 
Regards,
   __  ___     ___ ____  __
  /  |/  /_ __/ __/ __ \/ /    Mr. Sinisa Milivojevic <sinisa@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__   MySQL AB, Fulltime Developer
/_/  /_/\_, /___/\___\_\___/   Larnaca, Cyprus
       <___/   www.mysql.com

