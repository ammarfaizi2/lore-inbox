Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132239AbRA3TBU>; Tue, 30 Jan 2001 14:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132293AbRA3TBL>; Tue, 30 Jan 2001 14:01:11 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:37362 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S132239AbRA3TBA>; Tue, 30 Jan 2001 14:01:00 -0500
Message-ID: <3A770F68.7D54CEB9@inet.com>
Date: Tue, 30 Jan 2001 13:00:56 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kernelnewbies@humbolt.nl.linux.org
Subject: peek/poke question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm being asked to read values from arbitrary locations on the PCI
bus... but I need to do that without altering the kernel... is there a
way to do that as root?

>From what I understand, /proc/kcore has only the physical RAM.

TIA,

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
