Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSKTEwY>; Tue, 19 Nov 2002 23:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSKTEwY>; Tue, 19 Nov 2002 23:52:24 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:31989 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265752AbSKTEwX>; Tue, 19 Nov 2002 23:52:23 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Nov 2002 23:58:39 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  November 20, 2002
Message-ID: <3DDAD02F.20099.6C0FB39E@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [64.152.17.166] at Tue, 19 Nov 2002 22:59:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This week's kernel status is available at the usual URL:
  http://www.kernelnewbies.org/status

Question for the crowd:
Does anyone know what is the status of these "cleanup" items? 

o in -mm  Avoid dcache_lock while path walking  (Maneesh Soni, IBM team)  
o Ready  Switch to ->get_super() for file_system_type  (Al Viro)  
o Beta  file.h and INIT_TASK  (Benjamin LaHaise)  
o Beta  Proper UFS fixes, ext2 and locking cleanups  (Al Viro)  
o Beta  Lifting limitations on mount(2)  (Al Viro)  

Unless I hear otherwise, I will remove them soon, they have been 
in there forever.
Thanks!

-- Guillaume
