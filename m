Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCROOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCROOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVCROOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:14:37 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:56717 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261609AbVCROOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:14:35 -0500
Message-ID: <423AE247.3060806@euroweb.net.mt>
Date: Fri, 18 Mar 2005 15:14:31 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Juergen Quade <quade@hsnr.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel space sockets
References: <423ADD5B.5060708@euroweb.net.mt> <20050318140941.GA31622@hsnr.de>
In-Reply-To: <20050318140941.GA31622@hsnr.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Quade wrote:

>On Fri, Mar 18, 2005 at 02:53:31PM +0100, Josef E. Galea wrote:
>  
>
>>Hi,
>>
>>I'm trying to implement a UDP server in a kernel module. So far I have 
>>created the struct socket using sock_create_kern(), and used 
>>sock->ops->bind() on it. Now how do I send UDP datagrams? I looked at 
>>some code and found the function sock->ops->sendmsg() but I can't figure 
>>out where to put the destination address. I would appreciate it if 
>>someone could point me to some tutorial or sample code.
>>    
>>
>
>Maybe the sample code on this (german) site helps:
>
>http://ezs.kr.hsnr.de/TreiberBuch/Artikel/index.html
>
>Look at "Folge" 16.
>
>          Juergen.
>
>  
>
Thanks :)
Josef
