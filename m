Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVHSLMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVHSLMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVHSLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:12:05 -0400
Received: from karen.nerdshack.com ([209.189.235.41]:54986 "EHLO
	karen.nerdshack.com") by vger.kernel.org with ESMTP id S932623AbVHSLME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:12:04 -0400
Message-ID: <430558C2.7050708@nerdshack.com>
Date: Fri, 19 Aug 2005 03:57:54 +0000
From: smiling_23 <smiling_23@nerdshack.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: second_overflow
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am trying to understand the timer adjustment calculation in 
Linuxkernel 2.6.12.5.
How the time_adj is going to effect the change in HZ.
For example if i modified the HZ to 2000. Then what will hapen to the 
time_adj. is there any separate
calculation of time_adj is required for HZ 2000.
Thanks.
Cjag


