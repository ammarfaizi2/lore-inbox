Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVCHA6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVCHA6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCHA5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:57:02 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:39106 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261987AbVCHAxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:53:10 -0500
Message-ID: <422CF779.6030508@euroweb.net.mt>
Date: Tue, 08 Mar 2005 01:53:13 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Feldman <sfeldma@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sending IP datagrams
References: <422CE853.8070603@euroweb.net.mt> <9b84705fe7666dfbbf1782ca85ae2ae0@pobox.com>
In-Reply-To: <9b84705fe7666dfbbf1782ca85ae2ae0@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman wrote:

>
> On Mar 7, 2005, at 3:48 PM, Josef E. Galea wrote:
>
>> Hi,
>>
>> Is there any way, other than socket buffers, to send IP datagrams 
>> from a kernel module? If yes, can you please point me to some good 
>> tutorial or sample code
>
>
> See net/core/pktgen.c for an example.
>
> -scott
>
AFAIK that module uses socket buffers (struct sk_buff) to send the 
packets. I was asking whether there was another way to send the IP 
datagrams.

Thanks for your reply :)

Josef
