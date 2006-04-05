Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWDERXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDERXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWDERXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:23:16 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:7377 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751282AbWDERXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:23:16 -0400
Message-ID: <4433FCF5.7080604@nortel.com>
Date: Wed, 05 Apr 2006 11:23:01 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: help? converting to single global prio_array in scheduler, ran
 into snag
References: <4433F636.3090705@nortel.com>
In-Reply-To: <4433F636.3090705@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2006 17:23:01.0639 (UTC) FILETIME=[974E0970:01C658D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should clarify that CKRM is currently disabled--I'm trying to get the 
vanilla scheduler working first before changing the CKRM stuff to use 
per-class prio arrays rather than per-class per-cpu ones.

Chris
