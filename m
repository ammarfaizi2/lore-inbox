Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283584AbRLIQUz>; Sun, 9 Dec 2001 11:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283621AbRLIQUq>; Sun, 9 Dec 2001 11:20:46 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:19842 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S283660AbRLIQUd>; Sun, 9 Dec 2001 11:20:33 -0500
Message-ID: <003801c180cd$51055700$0801a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/stat and disk_io
Date: Sun, 9 Dec 2001 16:19:45 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

from /proc/stat i get the following

disk_io: (3,0):(167751,94458,3917566,73293,2420568)
(3,1):(59314,45093,2747844,14221,114376)
(11,0):(9855,9855,1258392,0,0)

except the device 11,0 is a cd-reader
and there is a device 11,1 which has been used
is there any reson why the stats dont show up ?
after all it is another disk.

thanks
    James


--------------------------
Mobile: +44 07779080838
http://www.stev.org
  4:10pm  up 1 day, 17:44,  2 users,  load average: 0.08, 0.08, 0.02



