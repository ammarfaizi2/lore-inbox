Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312362AbSCUP30>; Thu, 21 Mar 2002 10:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312366AbSCUP3Q>; Thu, 21 Mar 2002 10:29:16 -0500
Received: from jalon.able.es ([212.97.163.2]:20657 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S312362AbSCUP3C>;
	Thu, 21 Mar 2002 10:29:02 -0500
Date: Thu, 21 Mar 2002 16:28:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac4
Message-ID: <20020321152852.GA2028@werewolf.able.es>
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu> <006101c1d084$275029b0$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.21 Adam Kropelin wrote:
>Alan Cox wrote:
>> Linux 2.4.19pre3-ac4
>
><snip>
>
>> o The incredible shrinking kernel patch (Andrew Morton)
>
>Is there a magic incantation I need in order to see an improvement from this?
>I'm observing a slight (< 10 KB) increase from -ac3 to -ac4. Same .config, same
>compiler.
>
>I only build 2 modules; everything else is static. Perhaps Andrew's fix is for
>heavy module users?
>

I think it gives about 100k size decrease IFF you have verbose BUG activated.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release cooker (Cooker) for i586
Linux werewolf 2.4.19-pre4-jam1 #1 SMP Thu Mar 21 02:05:01 CET 2002 i686
