Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbRE3WP7>; Wed, 30 May 2001 18:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262855AbRE3WPu>; Wed, 30 May 2001 18:15:50 -0400
Received: from jalon.able.es ([212.97.163.2]:9601 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262852AbRE3WPo>;
	Wed, 30 May 2001 18:15:44 -0400
Date: Thu, 31 May 2001 00:15:37 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reclaim dirty dead swapcache pages
Message-ID: <20010531001537.G1138@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0105301420000.5231-100000@freak.distro.conectiva> <Pine.LNX.4.21.0105301729080.5231-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0105301729080.5231-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, May 30, 2001 at 22:32:19 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.30 Marcelo Tosatti wrote:
> 
> 
> Its at
> http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.5ac4/reapswap.patch
> 
> Please test. 
> 

Which kind of test, something like the gcc think I posted recently ?
Just stress vm, fill swap, and try to do it again ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac4 #1 SMP Wed May 30 00:17:45 CEST 2001 i686
