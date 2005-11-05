Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVKEJmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVKEJmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKEJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:42:06 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:18605
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751318AbVKEJmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:42:05 -0500
Message-ID: <436C7E77.3080601@ed-soft.at>
Date: Sat, 05 Nov 2005 10:42:15 +0100
From: hostmaster <hostmaster@ed-soft.at>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New Linux Development Model
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

I tought long about writting this mail. I'm a linux use since many years.
At the moment i'll getting more then frustrated about the actual develoment
model of the kernel. In the latest releases things where broken from release
to release.
For example take the ipw2200 driver.
 From 2.6.12 -> 2.6.13 the header file ieee80211.h was incompatible with 
driver.
Also transfer speed decreased dramaticaly.
 From 2.6.13 -> 2.6.14 you included the ipw2200 driver. But in an too 
old version
without WPA support. The external driver on ipw2200.sourceforge.net 
seems not
to work with 2.6.14.
I had also several problems with some other not in kernel drivers.
I realy liked it to have the latest state of the art kernel, but at the 
moment i'm forced
to use 2.6.12 ( ipw2200 -> WPA ).
I can't understand it why you have to break compatibility from kernel 
release to kernel
release. Don't you think that this makes 3'rd party driver developers 
frustrated?
It can't be an option for 3'rd party developers and users to check if 
external drivers
still works with new kenrel releases.
 From my point of view the actual linux kernel is far away from a stable 
development
process.

cu

ED.

