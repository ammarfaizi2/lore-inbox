Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131585AbRCQJCf>; Sat, 17 Mar 2001 04:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131583AbRCQJC0>; Sat, 17 Mar 2001 04:02:26 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:53385 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131579AbRCQJCJ>; Sat, 17 Mar 2001 04:02:09 -0500
Message-ID: <3AB327F2.2F33CF7A@mvista.com>
Date: Sat, 17 Mar 2001 01:01:38 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Who did the time list insert code?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At https://high-res-timers.sourceforge.net we are trying to define a
high resolution timer patch for linux (please join us if you are
interested).  We would like to know who wrote the time list management
code that is currently in the kernel.

Or

Any help on any studies done on the nature of the timer list.  The code
seems to indicate that most entries are in the first 2.56 seconds from
NOW.  Has this been verified?  Are there other hidden issues we should
know about?

George
