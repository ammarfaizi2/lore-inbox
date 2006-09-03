Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWICWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWICWoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWICWoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:44:00 -0400
Received: from 8.ctyme.com ([69.50.231.8]:47820 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751102AbWICWn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:43:59 -0400
Message-ID: <44FB5AAD.7020307@perkel.com>
Date: Sun, 03 Sep 2006 15:43:57 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Raid 0 Swap?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I have two drives and I want swap to be fast if I allocate swap spam 
on both drives does it break up the load between them? Or would it run 
faster if I did a Raid 0 swap?


-- 
VGER BF report: H 0.286654
