Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbUCYR1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUCYR1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:27:37 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:32407 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263515AbUCYR0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:26:37 -0500
Message-ID: <40631649.9070000@blueyonder.co.uk>
Date: Thu, 25 Mar 2004 17:26:33 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.5-rc2-mm3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2004 17:26:34.0220 (UTC) FILETIME=[51EA92C0:01C4128E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Builds OK on Athlon  XP2200+, but froze at Freeing unused kernel memory: 
180k freed. SysRQ-B and on reboot, it got past that poing then froze 
solid later on. This is from boot.omsg, hope to gather more data later.
<6>Freeing unused kernel memory: 180k freed
<4>Removing [35127 37455 0x0 SD]..done
<4>Removing [3904 35127 0x0 SD]..done
<4>There were 2 uncompleted unlinks/truncates. Completed
<6>Adding 3823460k swap on /dev/hda2.  Priority:42 extents:1
<4>hdb: Speed warnings UDMA 3/4/5 is not functional.          ### THE 
CDROM ###
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

