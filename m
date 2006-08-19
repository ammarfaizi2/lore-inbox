Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWHSVaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWHSVaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWHSVaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 17:30:05 -0400
Received: from grace.univie.ac.at ([131.130.3.115]:2185 "EHLO
	grace.univie.ac.at") by vger.kernel.org with ESMTP id S1751221AbWHSVaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 17:30:02 -0400
Message-ID: <44E782D5.4080402@kittenberger.net>
Date: Sat, 19 Aug 2006 23:29:57 +0200
From: Axel Kittenberger <axell@kittenberger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Abnormal HTTP request termination.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List

On Linux 2.6 (exact 2.6.15) issuing a wget at this location 
http://www.wohin-heute.at/highlights.php results in a truncated file. 
Truncated before "</hmtl>.

First we suspected our firewall, but this proofed not be unguilty it seems.

I now tried that address on a lot machines on a lot of locations, but as 
it turns it will work everywhere except on Linux 2.6 machines.

The URI will wget fine on:
OpenBsd 3.9
AIX 3
Windows XP
Linux 2.4.10

Since thats not a really important site, this is an academic question 
after all :)

Has someone an idea, what may cause this network problem which seems to 
be limited to linux 2.6?

Greetings,
Axel Kittenberger
