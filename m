Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132485AbRCZRPD>; Mon, 26 Mar 2001 12:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132489AbRCZROn>; Mon, 26 Mar 2001 12:14:43 -0500
Received: from jalon.able.es ([212.97.163.2]:17840 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132485AbRCZROc>;
	Mon, 26 Mar 2001 12:14:32 -0500
Date: Mon, 26 Mar 2001 19:13:45 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ac25 - hang mounting swap
Message-ID: <20010326191345.C1189@werewolf.able.es>
In-Reply-To: <20010326114713.A1150@werewolf.able.es> <E14hYLr-0001mv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14hYLr-0001mv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 26, 2001 at 16:52:07 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.26 Alan Cox wrote:
> 
> See what it is looping through if you can
>

Well, my mail took a hundred years to get to the list, and in the meanwhile
I read the posts on the bugs in vmalloc.c. That solved my boot, now I'm
running ac25.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac25 #5 SMP Mon Mar 26 17:46:56 CEST 2001 i686

