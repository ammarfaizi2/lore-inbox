Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267608AbUHJTE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267608AbUHJTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267680AbUHJTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:02:40 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:45026 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267487AbUHJTC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:02:26 -0400
Message-ID: <41191BB4.4020109@us.ibm.com>
Date: Tue, 10 Aug 2004 14:02:12 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ibmveth bug fixes 2/4
References: <41190E8E.9050004@us.ibm.com> <1092162537.11212.27.camel@nighthawk>
In-Reply-To: <1092162537.11212.27.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about something like this that doesn't add more magic numbers?
> 
> I'm not so sure about the type, though.  Is that (u16) cast OK?

Yep... Thanks Dave... no magic numbers is good... and the (u16) cast is 
ok...

Andrew... please apply Dave's patch...

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center
