Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUB2IKx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUB2IKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:10:52 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:17094 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262010AbUB2IKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:10:50 -0500
Message-ID: <40419E7E.8090101@matchmail.com>
Date: Sun, 29 Feb 2004 00:10:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vipin <vipindravid@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Processor set functionality in linux
References: <20040228043450.53729.qmail@web12505.mail.yahoo.com>
In-Reply-To: <20040228043450.53729.qmail@web12505.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin wrote:
>  
>  Hi, 
> 
>  I would like to know if there is something in linux
> (2.4.21) akin to processor set feature available on HP
> /SUN . 
> 
>  Basically idea is to be able to dedicate a processor 
>  to a vertain high priority task with not even the  
>  interrupts being allowed to run there.

Yes.

I haven't had to do it myself, but search for "process affinity" and 
"interrupt affinity".

Mike
