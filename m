Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264209AbRFIMhE>; Sat, 9 Jun 2001 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264217AbRFIMgo>; Sat, 9 Jun 2001 08:36:44 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:34565 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264209AbRFIMgg>; Sat, 9 Jun 2001 08:36:36 -0400
Message-Id: <200106091236.f59CaWU47508@aslan.scsiguy.com>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC] aic7xxx loaded from initrd under 2.4.5 
In-Reply-To: Your message of "Fri, 08 Jun 2001 20:37:21 EDT."
             <a05100327b7471d549290@[129.98.91.150]> 
Date: Sat, 09 Jun 2001 06:36:32 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>A panic occurs at boot while the aic7xxx is doing its thing..the 
>following has been hand copied from the screen...

Unfortunately, this trace is somewhat useless.  Without symbol
references, it is impossible to say where the panic occurred
or where (symbol location is highly dependent on how and what you
compiled (into) your kenrel.  If the panic is completely reproduceable,
the easiest way to get a useful dump is to apply the SGI kdb patches
and get a real trace.

--
Justin
