Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbRGFMak>; Fri, 6 Jul 2001 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266597AbRGFMaU>; Fri, 6 Jul 2001 08:30:20 -0400
Received: from scan1.fhg.de ([153.96.1.35]:56008 "EHLO scan1.fhg.de")
	by vger.kernel.org with ESMTP id <S266520AbRGFMaM>;
	Fri, 6 Jul 2001 08:30:12 -0400
Message-ID: <3B45AEBD.8D0599E3@N-Club.de>
Date: Fri, 06 Jul 2001 14:27:41 +0200
From: Juergen Wolf <JuWo@N-Club.de>
Organization: AEMT Fraunhofer
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de> <20010706134421.B20614@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> Could you try 2.4.6 with just this modification: ?
> 

hm, looks like thats really the point. After applying your diff file
everything works fine.

Regards,
	Juergen
