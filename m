Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUCYRZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbUCYRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:23:12 -0500
Received: from 65.104.119.60.ptr.us.xo.net ([65.104.119.60]:12926 "EHLO
	dns1.appliedminds.com") by vger.kernel.org with ESMTP
	id S263464AbUCYRUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:20:50 -0500
Message-ID: <406314EF.7040304@appliedminds.com>
Date: Thu, 25 Mar 2004 09:20:47 -0800
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Figuring out USB device locations
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2004 17:20:47.0711 (UTC) FILETIME=[83617EF0:01C4128D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an easy way to find out what /dev entries usb devices get 
mapped to from userspace? Specifically mice since the /dev location 
isn't even printed in dmesg.
I have a program that needs to open each mouse independently so 
/dev/input/mice isn't an option.

I'm also on a 2.4 kernel so sysfs/udev is not available.

Thanks.
-- 
James Lamanna

