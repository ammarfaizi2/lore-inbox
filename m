Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTAHLEG>; Wed, 8 Jan 2003 06:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTAHLEG>; Wed, 8 Jan 2003 06:04:06 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:47817 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266095AbTAHLEG>; Wed, 8 Jan 2003 06:04:06 -0500
Message-Id: <4.3.2.7.2.20030108121021.00ae17a0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 08 Jan 2003 12:13:22 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.21-pre2 peculiarity
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, RTFM. However another question :

13 __generic_copy_to_user                              0.1566
10 __constant_c_and_count_memset              0.0781
16 __constant_memcpy                                     0.0620

I thought these guys are supposed to be inlined or ?

Margit

