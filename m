Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRGFHsp>; Fri, 6 Jul 2001 03:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266237AbRGFHsf>; Fri, 6 Jul 2001 03:48:35 -0400
Received: from scan2.fhg.de ([153.96.1.37]:11228 "EHLO scan2.fhg.de")
	by vger.kernel.org with ESMTP id <S265810AbRGFHs0>;
	Fri, 6 Jul 2001 03:48:26 -0400
Message-ID: <3B456D45.FBF10C1A@N-Club.de>
Date: Fri, 06 Jul 2001 09:48:21 +0200
From: Juergen Wolf <JuWo@N-Club.de>
Organization: AEMT Fraunhofer
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> Is X or something like a nvidia module enabled ?
> 

Hi,

 the nvidia modul is not loaded or enabled but X is running sometimes.
Anyways, it seems to happen if X is not running too.
Luckily I got a very helpfull hint from Hans-Christian Armingeon in
reply to my questions here on the list. The epic100.c from
http://lrcwww.epfl.ch/~boch/sw/epic100.c.txt fixes the problem in all
the affected kernel versions. 

Thanx for your help guys
	Juergen
