Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130259AbRBHVYX>; Thu, 8 Feb 2001 16:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRBHVYO>; Thu, 8 Feb 2001 16:24:14 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:57614 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S129681AbRBHVYD>; Thu, 8 Feb 2001 16:24:03 -0500
Date: Thu, 8 Feb 2001 13:23:58 -0800 (PST)
From: Douglas Rudoff <dougrud@speakeasy.org>
To: linux-kernel@vger.kernel.org
Subject: What values in /proc/cpuinfo can change?
Message-ID: <Pine.LNX.4.21.0102081316580.18442-100000@grace.speakeasy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of all the fields in /proc/cpuinfo, which ones aren't fixed (as long as
you keep the same processor)?

According to the HOWTO I know bogomips can change.

What about flags/features? Can things be done to a CPU to change the
flags?

Is cpu MHz a real measurement of the speed the CPU is running, or is it
a fixed number that is dependent on the CPU type?

I'm not currently a subscriber to the mailing list; Please cc me any
response to the list.

Thanks!

Doug Rudoff
dougrud@speakeasy.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
