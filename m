Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRHNU1O>; Tue, 14 Aug 2001 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270808AbRHNU1E>; Tue, 14 Aug 2001 16:27:04 -0400
Received: from smtp1.one.net ([216.23.22.220]:59398 "HELO us.net")
	by vger.kernel.org with SMTP id <S270795AbRHNU0x>;
	Tue, 14 Aug 2001 16:26:53 -0400
Message-ID: <054701c124ff$9311eb10$b214860a@amdmb>
From: "Ryan Shrout" <rshrout@amdmb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Slow SCSI Disk Access on AMI Elite 1600 controller
Date: Tue, 14 Aug 2001 16:27:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I am fairly new to all this, so bear with me as I try to explain the
problem fully.  :)

First, my problem was centered around Mysql.  I had a problem of processes
spawning and spawning (sometimes over 100 of them at a time).  A simply
mysqld restart would solve the matter for most of the day, but the problem
always persisited.  One the people in the mysql list pointed me to check my
disk performance.  I came up with this:



Ryan Shrout
Owner - Amdmb.com
http://www.amdmb.com/
rshrout@amdmb.com

