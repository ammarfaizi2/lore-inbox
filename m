Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTKWMSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTKWMSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 07:18:45 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:38789 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263370AbTKWMSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 07:18:44 -0500
Message-ID: <3FC0A4D3.9020604@cyberone.com.au>
Date: Sun, 23 Nov 2003 23:15:15 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Andi Kleen <ak@muc.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com, efocht@hpce.nec.com,
       John Hawkes <hawkes@sgi.com>, wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
References: <20031117021511.GA5682@averell> <3FB83790.3060003@cyberone.com.au> <20031117141548.GB1770@colin2.muc.de> <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au> <Pine.LNX.4.56.0311231300290.16152@earth>
In-Reply-To: <Pine.LNX.4.56.0311231300290.16152@earth>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>On Sun, 23 Nov 2003, Nick Piggin wrote:
>
>
>>We still don't have an HT aware scheduler, [...]
>>
>
>uhm, have you seen my HT scheduler patches, in particular the HT scheduler
>in Fedora Core 1, which is on top of a pretty recent 2.6 scheduler? Works
>pretty well.
>

No I have seen it. Sorry I know you have done so and it looks good. I
wouldn't be adverse to it being included, although Linus seems to be.
The changes I have made nearly give you it for free anyway.

I just meant that there is not one in Linus' tree yet.

Nick


