Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268908AbUIHH3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbUIHH3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268911AbUIHH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:29:50 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:62963 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268908AbUIHH3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:29:48 -0400
Message-ID: <413EB4EB.5000207@blueyonder.co.uk>
Date: Wed, 08 Sep 2004 08:29:47 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2004 07:30:12.0205 (UTC) FILETIME=[AD28A1D0:01C49575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something strange is happening on my two boxen, Asus A7N8X-E, Athlon 
XP3000+,  nForce2 based, FX5200 video, SuSE 9.1 and Acer 1501-LCe laptop 
x86_64 XP3000+ Mobile, Radeon 9600, SuSE 9.1 x84_64. Building the kernel 
either starting with a base of linux-2.6.8.tar.bz2 or with 
linux-2.6.9-rc1.tar.bz2 I get the same effect on both - on reboot, 
kernel selected, video puts out a feint shadow, disk activity ceases, 
hard reset required. The config is essentially that posted on the 
2.6.9-rc1-mm? CDROM bug  last week, I've since pruned some scsi and not 
required stuff out, makes no difference. Disabling acpi and apm also no 
difference.
Any previous kernel will boot, but most will give the previously 
described CDROM/DVD mount problem.
I will retrace my steps and separately download the kernel stuff to each 
box and see if that makes a difference as I seem to be the only one to 
have hit these strange errors.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

