Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAEVNb>; Fri, 5 Jan 2001 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRAEVNV>; Fri, 5 Jan 2001 16:13:21 -0500
Received: from user-83-49.jakinternet.co.uk ([194.88.83.49]:4373 "EHLO
	linux.home") by vger.kernel.org with ESMTP id <S129737AbRAEVNM>;
	Fri, 5 Jan 2001 16:13:12 -0500
Date: Fri, 5 Jan 2001 21:09:24 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/net/unix
Message-ID: <Pine.LNX.4.21.0101052107430.11582-100000@linux.home>
X-mailer: Pine 4.21
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

should there be 2 files in that diretory with the same name ?

mistral@sx:/proc/sys/net/unix$ ls -la
total 0
dr-xr-xr-x   2 root     root            0 Jan  5 21:09 ./
dr-xr-xr-x   8 root     root            0 Jan  5 21:09 ../
-rw-------   1 root     root            0 Jan  5 21:09 max_dgram_qlen
-rw-------   1 root     root            0 Jan  5 21:09 max_dgram_qlen
mistral@sx:/proc/sys/net/unix$ 

thats under 2.4.0

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  9:00pm  up 20 days,  8:04,  3 users,  load average: 0.35, 0.19, 0.08

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
