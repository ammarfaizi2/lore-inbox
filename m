Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUBZUyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUBZUyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:54:19 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:31422 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S261187AbUBZUyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:54:18 -0500
Message-ID: <403E5EF7.7080309@am.sony.com>
Date: Thu, 26 Feb 2004 13:02:47 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
References: <403E4363.2070908@am.sony.com> <Pine.LNX.4.53.0402261423170.4239@chaos>
In-Reply-To: <Pine.LNX.4.53.0402261423170.4239@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 26 Feb 2004, Tim Bird wrote:
> 
>>What's the rationale for not supporting interrupt priorities
>>in the kernel?
> 
> Interrupt priorities are supported and have been supported
> since the first cascaded interrupt controllers and, now
> with the APIC. 

Please forgive my ignorance.  I'm not sure what's going
on with 2.6 and work queues, but do the hardware priorities
allow you to control scheduling of interrupt bottom halves?

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

