Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273467AbRIYUDD>; Tue, 25 Sep 2001 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273465AbRIYUCq>; Tue, 25 Sep 2001 16:02:46 -0400
Received: from gateway.wvi.com ([204.119.27.10]:38600 "HELO gateway.wvi.com")
	by vger.kernel.org with SMTP id <S273464AbRIYUCc>;
	Tue, 25 Sep 2001 16:02:32 -0400
Message-ID: <3BB0E2F2.CD668D18@wvi.com>
Date: Tue, 25 Sep 2001 13:02:58 -0700
From: Jim Potter <jrp@wvi.com>
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question from linuxppc group
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have  a host bridge (plus PIC, mem ctlr, etc.) that is essentially
identical
for ppc and mips.  Where is the best place to put the code since we
don't want to
duplicate it for both architectures?

--
Sincerely,

Jim Potter
45th Parallel Processing
jrp@wvi.com

"It is rather for us to be here dedicated to the great
task remaining before us -- that from these honored dead
we take increased devotion to that cause for which they
gave the last full measure of devotion -- that we here
highly resolve that these dead shall not have died in vain,
that this nation under God shall have a new birth of
freedom, and that government of the people, by the people,
for the people shall not perish from the earth.

A. Lincoln, Gettysburg, 1863

ln -sf /dev/null /osama/bin/laden


