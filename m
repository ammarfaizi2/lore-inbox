Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbTCZXy6>; Wed, 26 Mar 2003 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTCZXy6>; Wed, 26 Mar 2003 18:54:58 -0500
Received: from [66.186.193.1] ([66.186.193.1]:26634 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262663AbTCZXy5>; Wed, 26 Mar 2003 18:54:57 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 19:09:09(EST) on March 26, 2003
X-HELO-From: [10.134.0.78]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: sisfb: two more little problems
From: Torrey Hoffman <thoffman@arnor.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048723564.1156.5.camel@rohan.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2003 16:06:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the problems with mode switching with fbcon, I have two other
problems with sisfb:

1. My gpm mouse cursor on the framebuffer console is a cyan rectangle
with a bright orange "G" in it.  Actually the G has a "^" accent over
it.  That's just when it's over a blank spot.  When I move it over other
characters, the character in the pointer changes.  However, it does work
for selecting text.

2. I can't seem to set the default video mode from the kernel command
line.  I have tried:

video=sis:1024x768-24@75
video=sisfb:1024x768-24@75

and neither one works.  What is the expected command line?

Thanks,

-- 
Torrey Hoffman <thoffman@arnor.net>

