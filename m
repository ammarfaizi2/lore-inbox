Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUBYDeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBYDea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:34:30 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:48011 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262465AbUBYDe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:34:27 -0500
Message-ID: <403C17BC.60603@matchmail.com>
Date: Tue, 24 Feb 2004 19:34:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403C0DBF.7040608@matchmail.com> <20040224190903.586bec30.akpm@osdl.org>
In-Reply-To: <20040224190903.586bec30.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
>> I have a dual CPU server that won't boot 2.6.3-mm3.  It will however 
>> boot vanilla 2.6.3.
>>
>> Right after is says "uncompressing kernel" and "booting" it hangs.
> 
> 
> Please triple-check the .config, then boot with
> 
> 	earlyprintk=vga
> 
> or set up a serial console and boot with
> 
> 	earlyprintk=serial[,ttySn[,baudrate]]

Brown paper bag time.

I tried booting an Athlon compiled kernel on a PIII. :-/

Mike
