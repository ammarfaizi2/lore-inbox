Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQL1CPH>; Wed, 27 Dec 2000 21:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQL1CO5>; Wed, 27 Dec 2000 21:14:57 -0500
Received: from confucius.usc.edu ([128.125.20.153]:50442 "EHLO
	confucius.usc.edu") by vger.kernel.org with ESMTP
	id <S129352AbQL1COr>; Wed, 27 Dec 2000 21:14:47 -0500
Date: Wed, 27 Dec 2000 17:38:10 -0800
From: Joaquin Rapela <rapela@sipi.usc.edu>
To: linux-kernel@vger.kernel.org
Subject: [rapela@sipi.usc.edu: SYN_SENT block]
Message-ID: <20001227173810.A27194@confucius.usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention. I am running RedHat 6.2 and the kernel release is
2.2.14-5smp.

Joaquin

----- Forwarded message from Joaquin Rapela <rapela@sipi.usc.edu> -----

Date: Wed, 27 Dec 2000 16:25:18 -0800
From: Joaquin Rapela <rapela@sipi.usc.edu>
To: linux-kernel@vger.kernel.org
Subject: SYN_SENT block
User-Agent: Mutt/1.2.5i

Hello,

I am not a linux kernel guy. I am running a spider that sometimes gets blocked
for long periods of time.  I run a "netstat -nto" and I observe a socket in 
state SYS_SENT that seems to be blocked. Its timer keeps on incrementing. 

Is there any way to avoid this blocking? Is this a bug in the kernel or
something wrong in my TCP/IP configuration/settings.

Thanks in advance, Joaquin


----- End forwarded message -----

-- 
Joaquin Rapela
PhD Student, Signal and Image Processing Institute
University of Southern California
3740 McClintock Ave, EEB 424
Los Angeles, CA 90089-2564
email: rapela@sipi.usc.edu
tel:   (213) 740-6430
fax:   (213) 740-4651
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
