Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbRE2BPV>; Mon, 28 May 2001 21:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbRE2BPB>; Mon, 28 May 2001 21:15:01 -0400
Received: from viper.haque.net ([66.88.179.82]:47005 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S261950AbRE2BOv>;
	Mon, 28 May 2001 21:14:51 -0400
Message-ID: <3B12F801.37FA7836@haque.net>
Date: Mon, 28 May 2001 21:14:41 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <3B12EE32.9B35F89F@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Ouch!  When compiling MySql, building sql_yacc.cc results in a ~300M
> cc1plus process size.  Unfortunately this leads the machine with 380M of
> RAM deeply into swap:
> 
> Mem:   381608K av,  248504K used,  133104K free,       0K shrd,     192K
> buff
> Swap:  255608K av,  255608K used,       0K free                  215744K
> cached
> 
> Vanilla 2.4.5 VM.
> 

Sorry. I just looked at your numbers again and saw you have 133 MB of
real ram free. Is this during compile?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
