Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbSLDXmm>; Wed, 4 Dec 2002 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSLDXml>; Wed, 4 Dec 2002 18:42:41 -0500
Received: from [209.184.141.189] ([209.184.141.189]:26953 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S267153AbSLDXml>;
	Wed, 4 Dec 2002 18:42:41 -0500
Subject: 2.4.20aa1 patch reversing problems.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1039045781.4250.37.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Dec 2002 17:49:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the full 2.4.20aa1 patch and patched a pristine 2.4.20. No
problems there. I then wanted to reverse all the XFS patches to apply
the latest stuff. To my surprise, I can't reverse several of the patches
without error. (at least 3 of the 7{0,1}_* patches)

I'm not sure why this would be, I've gone in order, and reverse order,
and I still get problems. It seems quite odd to me that this would
happen...since I thought the split patches would be in the full patch as
well. 

Is something amiss here? Help and advice is much appreciated.


--The GrandMaster
  <masterlee@digitalroadkill.net>
