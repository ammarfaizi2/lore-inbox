Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDQMiP>; Tue, 17 Apr 2001 08:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDQMhz>; Tue, 17 Apr 2001 08:37:55 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:21362 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132567AbRDQMhv>; Tue, 17 Apr 2001 08:37:51 -0400
Date: Tue, 17 Apr 2001 07:37:50 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104171237.HAA94681@tomcat.admin.navo.hpc.mil>
To: babydr@baby-dragons.com,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Is printing broke on sparc ?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. James W. Laferriere" <babydr@baby-dragons.com>:
[snip]
> 	.. ie:  cat /etc/printcap > /dev/lp0    (or /dev/par0)
> 	gets me :
> 
> /c#eodiecnyotai rhernili s to rpaemn
>                                     s eehpo o-.ROLPR0 roif{\=sl:x
>                                                                  	/p:ao/lr
> 	which is where it rolls off the paper .
> 	printer is a DECLaser 2200  .  I have the PostScript option card
> 	for it , but when it is installed -notthing- gets output so I
> 	tried the above experiment without it installed .  With the option
> 	installed the display shows 'PS Waiting' Then shortly 'PS
> 	Processing' then 'PS Ready' .  This happens whether I cat .ps
> 	files or not .  I beleive that something is garbling the data
> 	being sent .

I have the 5100 printer - It is expecting PCL when the PS option is not
set. With it set, it only prints postscript.

What I did was to pass the data through enscript/nenscript to convert
to postscript. Then I had no problems at all.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
