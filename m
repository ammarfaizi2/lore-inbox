Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUBGWUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUBGWUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:20:02 -0500
Received: from imap.gmx.net ([213.165.64.20]:24963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265853AbUBGWUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:20:00 -0500
X-Authenticated: #3450509
Message-ID: <402562D4.7010706@gmx.net>
Date: Sat, 07 Feb 2004 23:12:36 +0100
From: =?ISO-8859-1?Q?Georg_M=FCller?= <georgmueller@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031211 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpufreq - less possible freqs with 2.6.2 and P4M
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Pentium 4M at 1.8GHz.
With 2.6.0 it was possible to slow down my CPU in several steps down to 
200MHz via cpufreq.
With 2.6.2 I can only switch between 1.2 and 1.8GHz (as it was with 2.4 
too).

Is this change wanted?

Georg Müller
