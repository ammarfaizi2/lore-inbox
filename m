Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbTBYGal>; Tue, 25 Feb 2003 01:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTBYGak>; Tue, 25 Feb 2003 01:30:40 -0500
Received: from webmail17.rediffmail.com ([203.199.83.27]:39821 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267735AbTBYGaj>;
	Tue, 25 Feb 2003 01:30:39 -0500
Date: 25 Feb 2003 06:40:01 -0000
Message-ID: <20030225064001.20937.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
Reply-To: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: narendiran_srinivasan@satyam.com
Subject: Unresolved symbol error in __wake_up_sync
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
    We wrote a module in which we used wake_up_interruptible,
wake_up_interruptible_sync calls and when I compiled it into a      
module
with the appropriate Macros, it gets compiled properly.
 	But once, when I try to load the module with insmod, I get
__wake_up_sync -  unresolved symbol?
 	What module should I load to get out this error? I am using
2.4.7-10.

Please help us out.

Regards,
Sudharsan.

