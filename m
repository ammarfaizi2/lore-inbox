Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130833AbRAAWhs>; Mon, 1 Jan 2001 17:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbRAAWhh>; Mon, 1 Jan 2001 17:37:37 -0500
Received: from femail8.sdc1.sfba.home.com ([24.0.95.88]:10198 "EHLO
	femail8.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130833AbRAAWhZ>; Mon, 1 Jan 2001 17:37:25 -0500
Date: Mon, 1 Jan 2001 17:06:54 -0500
From: Ari Pollak <compwiz@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: devices.txt inconsistency
Message-ID: <20010101170654.A5856@sourceware.net>
Mail-Followup-To: Ari Pollak <compwiz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux darth 2.4.0-prerelease
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has not been fixed for at least a year that i can remember - in
Documentation/devices.txt, it says /dev/js* should be char-major-15*,
but in Documentation/joystick.txt it says it should be char-major-13.
I'm assuming joystick.txt is the correct one, and devices.txt should be
updated to reflect this.. before 2.4.0 would be nice.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
