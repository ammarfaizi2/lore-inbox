Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311552AbSCNMZm>; Thu, 14 Mar 2002 07:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311599AbSCNMZe>; Thu, 14 Mar 2002 07:25:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311552AbSCNMZV>;
	Thu, 14 Mar 2002 07:25:21 -0500
Message-ID: <3C9096A4.3050508@mandrakesoft.com>
Date: Thu, 14 Mar 2002 07:25:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <E16lU9w-0005GY-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>In message <3C9088F0.8090602@mandrakesoft.com> you write:
>
>>>It was an arbitrary and relatively crappy place to put it: I only put
>>>it there so PPC could use it...
>>>
>>Will other arches -ever- use the macro?  If not, include/asm-ppc is a 
>>better place...
>>
>>    Jeff "mountain out of a molehill" Garzik
>>
>
>Yes, clearly this is a decision which should not be rushed into.  I
>suggest long and vigorous debate on linux-kernel, with mentions of
>devfs, source control systems...
>
:)

Anyway, the patch looks good to me :)




