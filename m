Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJWFlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJWFlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJWFhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:37:31 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:44777 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267367AbUJWFes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:34:48 -0400
Message-ID: <4179EC91.2070100@cyberone.com.au>
Date: Sat, 23 Oct 2004 15:30:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Darren Hart <dvhltc@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Matt Dobson <colpatch@us.ibm.com>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] scheduler: active_load_balance fixes
References: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
In-Reply-To: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Darren Hart wrote:

>The following patch against the latest mm fixes several problems with
>active_load_balance().
>
>

This seems much better. Andrew can you put this into -mm please.

Thanks
Nick


