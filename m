Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTBQVHF>; Mon, 17 Feb 2003 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTBQVHF>; Mon, 17 Feb 2003 16:07:05 -0500
Received: from [194.87.44.233] ([194.87.44.233]:27083 "EHLO main.inves.ru")
	by vger.kernel.org with ESMTP id <S267489AbTBQVHE>;
	Mon, 17 Feb 2003 16:07:04 -0500
Date: Tue, 18 Feb 2003 00:17:03 +0300 (MSK)
From: anton <anton@inves.ru>
To: linux-kernel@vger.kernel.org
Subject: about kacpidpc
Message-ID: <Pine.LNX.3.96.1030218001548.31385C-100000@main.inves.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello everybody! 
 I have two questions conserning the process named kacpidpc:

1)what this process is? could anyone answer me or give any reference about
it.

2)I had a trouble with this process, may be someone could explain me,
where this problem went from. The problem was:

I have a server under linux debian 2.4.17 and it happened two times, that
all my disck space finished, becouse the file pacct grew anormously, if i
tried to look lastcomm it all was filled with lines like:  

kacpidpc           F    root     ??         0.00 secs Mon Feb 17 23:32
kacpidpc           F    root     ??         0.00 secs Mon Feb 17 23:32
kacpidpc           F    root     ??         0.00 secs Mon Feb 17 23:32
kacpidpc           F    root     ??         0.00 secs Mon Feb 17 23:32
  
 Thanks in advance, with respect, Anton Lizunov


