Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbRGCItw>; Tue, 3 Jul 2001 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRGCItm>; Tue, 3 Jul 2001 04:49:42 -0400
Received: from nwcst314.netaddress.usa.net ([204.68.23.59]:6839 "HELO
	nwcst314.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S265629AbRGCIt0> convert rfc822-to-8bit; Tue, 3 Jul 2001 04:49:26 -0400
Message-ID: <20010703084924.4981.qmail@nwcst314.netaddress.usa.net>
Date: 3 Jul 2001 02:49:24 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: shared memory problem
X-Mailer: USANET web-mailer (34FM.0700.18.03B)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
                     I have some confusion regarding key in shmget(). Let I
have two shared memory variables. For the first one, I put key "99" and the
size is 1024. Next, I put key "199" for the second variable  and size 1024.
Will the two shared memory area overwrite each other. How can I gurranty. Is
the Linux kernel    or the developer who should care about this problem
                      by
                                BLesson
