Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKVKjp>; Wed, 22 Nov 2000 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQKVKjf>; Wed, 22 Nov 2000 05:39:35 -0500
Received: from mail.zmailer.org ([194.252.70.162]:18445 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129231AbQKVKj2>;
	Wed, 22 Nov 2000 05:39:28 -0500
Date: Wed, 22 Nov 2000 12:09:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: 64738 <schwung@rumms.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bits
Message-ID: <20001122120916.Z28963@mea-ext.zmailer.org>
In-Reply-To: <974881546.3a1b830ae5202@rumms.uni-mannheim.de> <20001122112952.Y28963@mea-ext.zmailer.org> <974886395.3a1b95fb43c63@rumms.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974886395.3a1b95fb43c63@rumms.uni-mannheim.de>; from schwung@rumms.uni-mannheim.de on Wed, Nov 22, 2000 at 10:46:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 10:46:35AM +0100, 64738 wrote:
> uname -m tells me the hardware type of the machine. Is this determined while 
> booting or is this the architecture I choose during 'make config'? 

	Mainly chosen during "make config".
	Processor info you see at  /proc/cpuinfo

> Can't I run a i386 kernel on a ia64 machine? I know something like this
> from HP-UX. You can choose between a 32 and a 64 bit kernel when
> installing, so knowing that you have a 64 bit capable machine does not
> say that you have a 64 bit kernel.
> And I want to have the kernel bits, not the processor bits.

	Solaris runs 32-bit kernels on 64-bit UltraSPARCs
	(up to Solaris version 2.6)

	So yes, something like that MAY be possible in case
	of ia64, but somehow I doubt...

 
/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
