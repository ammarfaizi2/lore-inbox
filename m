Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSGIQZr>; Tue, 9 Jul 2002 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGIQZq>; Tue, 9 Jul 2002 12:25:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31181 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317193AbSGIQZp>;
	Tue, 9 Jul 2002 12:25:45 -0400
Message-ID: <3D2B0F0C.5050108@us.ibm.com>
Date: Tue, 09 Jul 2002 09:27:56 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Fugmann <afu@fugmann.dhs.org>
CC: Linux-kernel <linux-kernel@vger.kernel.org>,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: Chatserver workload simulator by Bill Hartner?
References: <3D2AA82C.7030305@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann wrote:
> I'm looking for the chatserver workload simulator made by Bill hartner, 
> which was used to test the O(1) scheduler by Ingo Molnar.
> 
> Does anyone know where to find it? - All I can find is the VolanoMark,
> but I guess that this is not the one used, since the command used by 
> Ingo Molnar when benchmarking the O(1) scheduler is: './chat_c 127.0.0.1 
> 10 100'.

Volanomark is probably the one, although I didn't know that Bill 
Hartner made it.  It is one of the benchmarks that we use quite a bit.

BTW, why didn't you ask Bill Hartner?

-- 
Dave Hansen
haveblue@us.ibm.com

