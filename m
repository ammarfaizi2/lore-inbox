Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTBYOfT>; Tue, 25 Feb 2003 09:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTBYOfT>; Tue, 25 Feb 2003 09:35:19 -0500
Received: from webmail16.rediffmail.com ([203.199.83.26]:57816 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267622AbTBYOfR>;
	Tue, 25 Feb 2003 09:35:17 -0500
Date: 25 Feb 2003 14:44:11 -0000
Message-ID: <20030225144411.2384.qmail@webmail16.rediffmail.com>
MIME-Version: 1.0
From: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
Reply-To: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Unresolved symbol error in __wake_up_sync
Content-type: multipart/mixed;
	boundary="Next_1046184251---0-203.199.83.26-2382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a multipart mime message


--Next_1046184251---0-203.199.83.26-2382
Content-type: text/plain;
	format=flowed
Content-Disposition: inline

Sorry for resending this mail.We are struck in the midst of our 
project.
Please can anyone help me out regarding the same.

Note: Forwarded message attached

-- Orignal Message --

 From: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: narendiran_srinivasan@satyam.com
Subject: Unresolved symbol error in __wake_up_sync


--Next_1046184251---0-203.199.83.26-2382
Content-type: message/rfc822

MIME-Version: 1.0
Message-ID: <20030225064001.20937.qmail@webmail17.rediffmail.com>
From: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: narendiran_srinivasan@satyam.com
Subject: Unresolved symbol error in __wake_up_sync
Content-type: text/plain;
	format=flowed
Content-Disposition: inline

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--Next_1046184251---0-203.199.83.26-2382--

