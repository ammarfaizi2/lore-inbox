Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132799AbRDUSJM>; Sat, 21 Apr 2001 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132802AbRDUSJB>; Sat, 21 Apr 2001 14:09:01 -0400
Received: from babel.spoiled.org ([212.84.234.227]:38477 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S132799AbRDUSIr>;
	Sat, 21 Apr 2001 14:08:47 -0400
Date: 21 Apr 2001 18:08:45 -0000
Message-ID: <20010421180845.18802.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Crash: XFree86 4.0.3 and Kernel 4.0.3
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <3AE1B7F7.4000505@bigfoot.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:
> I hate to report this again, I saw some reports that it was fixed with 
> 4.0.3 of XFree86, so I tried XF86 4.0.3 with RedHat 7.1.
> 
> Any time it tries to turn the monitor off, it crashes.  I get no oopses.
> Nothing.
> 
> Has anyone figured out why it crashes?  How can I fix it besides remove 
> the power savings option of automatically shutting the monitor off? 
> BTW, I am running this box with ACPI.  It crashes even more if I use 
> APM.  I never could figure that out, but anyway.

Hi Trevor,

I have the same problem with almost the same combination (RH 7.0 instead of
RH 7.1). Did you compile the XFree server yourself and if so, did you
optimize it for i686? The reason why I'm asking is that I did that and
suspected the optimazions to cause the crashes.

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

