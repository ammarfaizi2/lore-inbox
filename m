Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289748AbSAXAko>; Wed, 23 Jan 2002 19:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289854AbSAXAjn>; Wed, 23 Jan 2002 19:39:43 -0500
Received: from firewall.digsol.net ([63.228.1.219]:60411 "EHLO
	flanders.digsol.net") by vger.kernel.org with ESMTP
	id <S289748AbSAXAji>; Wed, 23 Jan 2002 19:39:38 -0500
Date: Wed, 23 Jan 2002 18:39:32 -0600
From: "Marc A. Ohmann" <marc@ds6.net>
To: linux-kernel@vger.kernel.org
Subject: AMD 2.4.17 hard freeze
Message-ID: <20020123183932.A5077@flanders.digsol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is related to the "Athlon PSE/AGP Bug" thread since that seems to be openGL related.

I recently built an Athlon 1700+, 1GB DDR, GeForce2 MX-400 AGP system on a Soyo SY-K7V Dragon for a customer.  Slack 8 installed without a hitch but once I got the system up and running 2.4.17 the system would randomly freeze.  The freezes often happen during kernel compiles but they have also happened under no load at all.

I thought it sounded like a hardware problem but I installed W2k on it the other night and now it has been up for 2 days with no problems.

I really don't have much to offer for diagnostics but I am willing to try anything that is suggested.

The freezes seem to be fairly repeatable and happen on 8/10 kernel compiles.  I have tried compiling in init 3 and with no modules loaded but it still freezes.

Thanks for any help,
 
-- 
------ Marc A. Ohmann  marc@ds6.net ------ Digital Solutions, Inc. ------
|                                    |   .~.                            | 
|  - Internet Hosting                |   /V\          L I N U X         | 
|  - Application Programming         |  // \\                           |
|  - Network Administration          | /(   )\    Solution Provider     |
|                                    |  ^^-^^                           |
-----------<a href="http://ds6.net">Digital Solutions, Inc</a>-----------
