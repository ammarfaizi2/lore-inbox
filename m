Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282048AbRKVFdD>; Thu, 22 Nov 2001 00:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282047AbRKVFcw>; Thu, 22 Nov 2001 00:32:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5388 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282046AbRKVFct>; Thu, 22 Nov 2001 00:32:49 -0500
Message-ID: <3BFC8DE8.7040202@zytor.com>
Date: Wed, 21 Nov 2001 21:32:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: war <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <9ti26k$331$1@cesium.transmeta.com> <3BFC8D81.E25238D1@starband.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:

> Yeah, but when the disk starts swapping the system slows down to a halt.
> 


No, when the disk starts *THRASHING* the system slows down to a halt. 
If you are thrashing with swap you would be thrashing much worse without 
swap.

	-hpa


