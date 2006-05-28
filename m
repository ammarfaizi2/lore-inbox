Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWE1PHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWE1PHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 11:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWE1PHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 11:07:12 -0400
Received: from dvhart.com ([64.146.134.43]:25743 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750777AbWE1PHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 11:07:11 -0400
Message-ID: <4479BC92.1090900@mbligh.org>
Date: Sun, 28 May 2006 08:06:58 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>
Subject: rc5-git1 and later fail to boot on x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain -rc5 seems fine. Double checking this isn't a machine issue, but
it seems to boot the older kernels just fine.

good boot is here: http://test.kernel.org/abat/33283/debug/console.log
for comparison

----------------------------

http://test.kernel.org/abat/33427/debug/console.log

Starting system log daemon: syslogd  syslogd: network logging disabled 
(syslog/udp service unknown).
   syslogd: see syslogd(8) for details of whether and how to enable it.: 
Operation not permitted

