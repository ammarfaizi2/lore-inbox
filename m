Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVICJM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVICJM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVICJM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:12:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23571 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750824AbVICJM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:12:27 -0400
Date: Sat, 3 Sep 2005 10:12:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, Scott_Kilau@digi.com
Subject: Fwd: [Bug 5176] New: file:Documentation/jsm.txt  is missing
Message-ID: <20050903101221.B29708@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Scott_Kilau@digi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone may like to deal with this.  Maybe the file should be placed
in the Documentation/serial directory?

----- Forwarded message from bugme-daemon@kernel-bugs.osdl.org -----
Date: Sat, 3 Sep 2005 01:43:16 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 5176] New: file:Documentation/jsm.txt  is missing

http://bugzilla.kernel.org/show_bug.cgi?id=5176

           Summary: file:Documentation/jsm.txt  is missing
    Kernel Version: 2.6.13
            Status: NEW
          Severity: low
             Owner: rmk@arm.linux.org.uk
         Submitter: h.rueter@gmx.de


Not really a bug,
but i'm missing this file.

Help in "make menuconfig"
{
-> Device Drivers                                                   
  x       -> Character devices     
  x         -> Serial drivers    
}

says it could be found in "linux-2.6.13/Documentation/jsm.txt"

Probably just a little copyjob for the developer ...

Greets Harry

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
