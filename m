Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVEXAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVEXAki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEXAki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:40:38 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:53671 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261256AbVEXAjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:39:00 -0400
Message-ID: <429277A2.50100@bigpond.net.au>
Date: Tue, 24 May 2005 10:38:58 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [ANNOUNCE][RFC] PlugSched-5.0 for 2.6.11, 2.6.12-rc4 and 2.6.12-rc4-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Tue, 24 May 2005 00:38:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch of PlugSched-5.0 (containing ingosched, nicksched, staircase,
spa_no_frills and zaphod CPU schedulers) against a 2.6.11 kernel is
available for download from:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.0-for-2.6.11.patch?download>

for 2.6.12-rc4 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.0-for-2.6.12-rc4.patch?download>

and for 2.6.12-rc4-mm2 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.0-for-2.6.12-rc4-mm2.patch?download>

PlugSched's version number has been bumped to 5.0 as further reductions
in the scheduler drive interface have been introduced.  Con Kolivas's 
"nice" aware load balancing patch has also been applied.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
