Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269213AbRHBXNG>; Thu, 2 Aug 2001 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269218AbRHBXMr>; Thu, 2 Aug 2001 19:12:47 -0400
Received: from jalon.able.es ([212.97.163.2]:51617 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S269213AbRHBXMd>;
	Thu, 2 Aug 2001 19:12:33 -0400
Date: Fri, 3 Aug 2001 01:18:25 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <laughing@shared-source.org>
Subject: Re: more extern -> inline for gcc3
Message-ID: <20010803011825.A9852@werewolf.able.es>
In-Reply-To: <20010803010549.A2210@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010803010549.A2210@werewolf.able.es>; from jamagallon@able.es on Fri, Aug 03, 2001 at 01:05:49 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010803 J . A . Magallon wrote:
>Hi.
>
>Just building 2.4.7-ac3 with gcc-3.0.1 snapshot from mandrake. Found another couple
>of extern __inline__ -> static __inline__ changes needed (oh, it is only x86, I think
>other archs will need the same):
>

Well, I relized it is just the 00_gcc-30 from Andrea..
Please, include this is next patch set...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac3 #1 SMP Mon Jul 30 16:39:36 CEST 2001 i686
