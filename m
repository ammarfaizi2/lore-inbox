Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCERjs>; Mon, 5 Mar 2001 12:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130090AbRCERjj>; Mon, 5 Mar 2001 12:39:39 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:6940 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130065AbRCERj3>;
	Mon, 5 Mar 2001 12:39:29 -0500
Message-ID: <3AA3CEE8.1ABDB27D@sgi.com>
Date: Mon, 05 Mar 2001 09:37:44 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <3AA3CC99.5549C6B2@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Slightly less annoying -- when no CD is in the drive, I'm getting:

Mar  5 09:30:42 xena kernel: VFS: Disk change detected on device ide1(22,0)
Mar  5 09:31:17 xena last message repeated 7 times
Mar  5 09:32:18 xena last message repeated 12 times
Mar  5 09:33:23 xena last message repeated 13 times
Mar  5 09:34:24 xena last message repeated 12 times

(22,0 = /dev/hdc,cdrom)

Perturbing.

-l
