Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274075AbRIXRZ4>; Mon, 24 Sep 2001 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274074AbRIXRZq>; Mon, 24 Sep 2001 13:25:46 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:21429 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S274071AbRIXRZ2>; Mon, 24 Sep 2001 13:25:28 -0400
Date: Mon, 24 Sep 2001 12:24:49 -0500
From: Dave McCracken <dmc@austin.ibm.com>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>,
        =?ISO-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <81350000.1001352289@baldur>
In-Reply-To: <3BAF688B.5090508@fugmann.dhs.org>
In-Reply-To: <Pine.LNX.4.33.0109241851281.3698-100000@grignard.amagerkollegiet
 .dk> <3BAF688B.5090508@fugmann.dhs.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, September 24, 2001 19:08:27 +0200 Anders Peter Fugmann 
<afu@fugmann.dhs.org> wrote:

>> IIRC, vmware includes one or more kernel modules.
>>
>> Rasmus
>>
> Yes, but the modules are not binary-only.
> The sourcecode is in the package, although it is not GPL.

I believe they only provide source for an interface layer that can be 
compiled against a specific version of the kernel.  I think the core 
drivers are binary only.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmc@austin.ibm.com                                      T/L   678-3059

