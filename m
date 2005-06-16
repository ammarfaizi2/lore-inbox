Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVFPEW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVFPEW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVFPEW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:22:57 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21489 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261733AbVFPEW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:22:56 -0400
Message-ID: <42B0FE88.1070404@nortel.com>
Date: Wed, 15 Jun 2005 22:22:32 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Todd Kneisel <todd.kneisel@bull.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch] robust futexes for 2.6.12-rc6
References: <42B0B5FD.3010309@bull.com>
In-Reply-To: <42B0B5FD.3010309@bull.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Kneisel wrote:
> This patch adds robust futex support to the existing sys_futex system call.
> The patch applies to 2.6.12-rc6. I have tested this code on an IA64 SMP
> system. Any comments or discussion will be welcome.

How does this compare to the robust mutexes portion of the stuff that 
Inaky was working on?

Chris
