Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRBYUB2>; Sun, 25 Feb 2001 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRBYUBS>; Sun, 25 Feb 2001 15:01:18 -0500
Received: from rachael.franken.de ([193.175.24.38]:44812 "EHLO
	rachael.franken.de") by vger.kernel.org with ESMTP
	id <S129660AbRBYUBI>; Sun, 25 Feb 2001 15:01:08 -0500
Date: Sun, 25 Feb 2001 20:55:21 +0100
From: Matthias Bruestle <m@mbsks.franken.de>
To: linux-kernel@vger.kernel.org
Subject: Power management on Sony C1Vx
Message-ID: <20010225205521.C3253@mbsks.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note as stated in the FAQ: I am not subscribed, so please CC also to me,
when answering. (Or else my spies have to do this. :) )

Mahlzeit


I have been told, that I might get help here. I have a Sony VAIO C1Vx.
(In my case x=E.) My problem is the power management, i.e. standby and
suspend. I was not able to get it working (properly). Is here someone
who got it working or knows, that it will not work?

My tries so far:

2.4.2 with APM:

- Fn+Fxx does nothing.
- standby makes the display black, but switches not the backlights off.
  The only way to go back to normal is by switching to a text console
  and then back to X.
- suspend is done properly, but to only way to get back to normal is
  by switching the computer off and then boot again.

2.2.16 with APM:

- Same as above.

2.4.2 with ACPI:

- I have compiled 2.4.2 with ACPI and without APM. acpid is started.
- Fn-Fxx does hang the display and probably computer until a few seconds
  after pressing a key or mouse button.
- Don't know no other way of going into suspend or standby with ACPI.

2.4.2-ac3 with ACPI:

- Same as above, but Fn-Fxx does nothing.

So do I wasting here my time or is it possible to get standby/suspend
working with the C1Vx? Has somebody got it working with APM or ACPI?
Some pointers or even a detailed description?


Thanks all

endergone Zwiebeltuete

PS: I have installed Red Hat 7.0 (aka Little Red Ridinghood).

-- 
live free or die
