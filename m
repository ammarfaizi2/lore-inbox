Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132066AbQL1BCR>; Wed, 27 Dec 2000 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbQL1BCG>; Wed, 27 Dec 2000 20:02:06 -0500
Received: from confucius.usc.edu ([128.125.20.153]:47368 "EHLO
	confucius.usc.edu") by vger.kernel.org with ESMTP
	id <S132066AbQL1BBz>; Wed, 27 Dec 2000 20:01:55 -0500
Date: Wed, 27 Dec 2000 16:25:18 -0800
From: Joaquin Rapela <rapela@sipi.usc.edu>
To: linux-kernel@vger.kernel.org
Subject: SYN_SENT block
Message-ID: <20001227162518.A25171@confucius.usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not a linux kernel guy. I am running a spider that sometimes gets blocked
for long periods of time.  I run a "netstat -nto" and I observe a socket in 
state SYS_SENT that seems to be blocked. Its timer keeps on incrementing. 

Is there any way to avoid this blocking? Is this a bug in the kernel or
something wrong in my TCP/IP configuration/settings.

Thanks in advance, Joaquin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
