Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWEBQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWEBQyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWEBQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:54:38 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:17286 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S964926AbWEBQyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:54:38 -0400
Message-ID: <44578EB9.8050402@nortel.com>
Date: Tue, 02 May 2006 10:54:17 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de>
In-Reply-To: <p73slns5qda.fsf@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 16:54:19.0266 (UTC) FILETIME=[0DD80620:01C66E09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Agreed it's a problem, but probably a small one. At worst you'll get
> a small scheduling hickup every half year, which should be hardly 
> that big an issue.

Presumably this would be bad for soft-realtime embedded things.  Set-top 
boxes, etc.

Chris
