Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWJEOar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWJEOar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWJEOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:30:46 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:62918 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932082AbWJEOaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:30:46 -0400
Message-ID: <45251714.4020006@gmail.com>
Date: Thu, 05 Oct 2006 16:30:44 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [question] rtc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.51.75
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- can rtc class behave as a drivers/char/rtc.c. I implemented an interface for 
myself, but it doesn't work, because there seems not to be an rtc driver to take 
control of system rtc for sending events to the interface?

- if not, is there any easy way, how to get events from rtc in kernelspace?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
