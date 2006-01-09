Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWAIOSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWAIOSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAIOSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:18:49 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45813 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932257AbWAIOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:18:48 -0500
Date: Mon, 09 Jan 2006 08:18:26 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
In-reply-to: <5t5JU-7Sn-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C270B2.4050305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5t06S-7nB-15@gated-at.bofh.it> <5t34G-3Zu-21@gated-at.bofh.it>
 <5t5pU-7tD-37@gated-at.bofh.it> <5t5JU-7Sn-11@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Rastrigin wrote:
> Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
> strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
> Whenever it is needed by apps I'm launching or working with. 

There is no different VM policy here, Windows behaves quite similarly. 
It does not leave memory around unused, it uses it for disk cache.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

