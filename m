Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278703AbRJTBTA>; Fri, 19 Oct 2001 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278711AbRJTBSu>; Fri, 19 Oct 2001 21:18:50 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:397 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S278703AbRJTBSi>;
	Fri, 19 Oct 2001 21:18:38 -0400
From: Richard Garand <krogoth2@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Promise FastTrak boot freeze on 2.4.12/+ac3
Date: Fri, 19 Oct 2001 19:18:17 -0600
X-Mailer: KMail [version 1.3.1]
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BD0CFF2.00002135@softhome.net>
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a Promise FastTrak 66 controller with a custom slackware 8 
bootdisk, and every time I try to boot it freezes after detecting hde, hdg, 
ide10 ide2, and ide3 (I have one drive on each port on the controller in 
RAID0 and a CD on the main IDE bus). I tried with kernel 2.4.12 and 
2.4.12-ac3, enabling both Promise FastTrak options (one for the controller, 
one for IDE RAID) and software RAID. I've done searches on google and their 
newsgroup archives and haven't found anything describing a solution to this 
problem. 

I will do my best to provide any additional information that could help if 
this is a new problem, but it can be a bit slow since I can only transfer it 
by swapping the video cable and using BioLink (TM of RealLife, INC).
-- 
Richard Garand
krogoth2@softhome.net, r.garand@sk.sympatico.ca
(L)ICQ: 12190132
Then: I have discovered a truly remarkable proof which this margin is too 
small to contain.
Now: Microsoft has released an unremarkable product which your hard drive is 
too small to contain.
