Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284090AbRLMPJ5>; Thu, 13 Dec 2001 10:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLMPJr>; Thu, 13 Dec 2001 10:09:47 -0500
Received: from jalon.able.es ([212.97.163.2]:24288 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S284090AbRLMPJk>;
	Thu, 13 Dec 2001 10:09:40 -0500
Date: Thu, 13 Dec 2001 16:10:02 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "David S. Miller" <davem@redhat.com>
Cc: bodnar42@phalynx.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: Network related
Message-ID: <20011213161002.A26081@werewolf.able.es>
In-Reply-To: <E16EKmH-0003EP-00@the-village.bc.nu> <E16EKv4-00034x-00@phalynx> <20011212.182742.55723846.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011212.182742.55723846.davem@redhat.com>; from davem@redhat.com on Thu, Dec 13, 2001 at 03:27:42 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011213 David S. Miller wrote:
>   From: Ryan Cumming <bodnar42@phalynx.dhs.org>
>   Date: Wed, 12 Dec 2001 17:44:18 -0800
>   
>   If more of the internet fit in to the 'A' catagory than the 'B'
>   catagory, I'd be very tempted to enable ECN and crusade against the
>   remaining deviants, but right now it seems like merely an annoyance
>   with no real gains.
>
>Amusingly the only web site I regularly visit for which I have to
>explicitly turn ECN off is www.sun.com :-)
>

My ISP uses Solaris boxes for mail service and so on. I had to unsubscribe
of LKML from that address due to ENC. The damned solaris box trashed
ECN enabled packets so vger could not reach it. Now I am subscribed
from an IRIX box and it works.

The admin of the Solaris boxes told me he was talking with Sun... that
was months ago.

Anybody knows if Sun firewall soft is already ECN aware ?

Thanks.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-pre8-beo #2 SMP Tue Dec 11 00:00:10 CET 2001 i686
