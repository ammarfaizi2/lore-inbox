Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRIXWJi>; Mon, 24 Sep 2001 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274193AbRIXWJa>; Mon, 24 Sep 2001 18:09:30 -0400
Received: from [12.32.79.65] ([12.32.79.65]:12292 "HELO
	localhost.blazeconnect.net") by vger.kernel.org with SMTP
	id <S274199AbRIXWJR>; Mon, 24 Sep 2001 18:09:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jason Straight <jason@blazeconnect.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 power management lockup
Date: Mon, 24 Sep 2001 18:04:32 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924220433.29ED8763@localhost.blazeconnect.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Dell Inspiron 8000 laptop, I had problems with 2.4.9 and .8 with 
AC patches where my system would turn itself off at seemingly random 
intervals, and closing my display would freeze the machine. 

Well, 2.4.9 clean was fine as was 2.4.8, but now 2.4.10 is doing it again, I 
upgraded my BIOS to the newest avail just in case with no change. 2.4.10 
doesn't seem to power off, but it will freeze on display close and will power 
off if the display is left closed for a while. All power management in my 
BIOS is off as it has been forever.j

I mentioned this on the list a while back with 2.4.8-ac-something





-- 
------------------------------------------
Jeet Kune Do does not beat around the bush. It does not take winding detours. 
It follows a straight line to the objective. Simplicity is the shortest 
distance between two points.
Bruce Lee - Tao of Jeet Kune Do
------------------------------------------

Jason Straight -- President
BlazeConnect -- Cheboygan Michigan
Phone: 231-597-0376 -- Fax: 231-597-0393
