Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTBUP6W>; Fri, 21 Feb 2003 10:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbTBUP6W>; Fri, 21 Feb 2003 10:58:22 -0500
Received: from mail.costarica.net ([196.40.25.178]:63950 "EHLO
	mail.costarica.net") by vger.kernel.org with ESMTP
	id <S267544AbTBUP6V>; Fri, 21 Feb 2003 10:58:21 -0500
Subject: Re: 2.4 series IDE troubles
From: "Miguel A. Bolanos" <mike@costarica.net>
To: shoninnaive@sbcglobal.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030221080120.45d30fec.home@lfs.pitchblende.org>
References: <20030221080120.45d30fec.home@lfs.pitchblende.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 10:15:31 -0600
Message-Id: <1045844131.2619.7.camel@nemesis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings John,
Please read /usr/src/linux-2.4/REPORTING-BUGS

Providing the info requested there, you will help the developers find a
solutions to this sooner.

Thanks

Mike


On Fri, 2003-02-21 at 07:01, j wrote:
> Hello,
> 
> IM not sure this is the way to go about this (obviously) but doing
> searchs at google for the error message I get just leads to the painful realization that there are many questions out there but 
> few answers. Anyhoo when I try adding a compact flash card as an 
> IDE drive to a system running under 2.4 I get kernel panics:
> 
>    VFS: Cannot open root device "307" or 03:07
>    Please append a corect "root=" boot option
>    Kernel panic: VFS: Unable to mount root
> 
> Just on a lark I decided to go back to a 2.2 series kernel (since
> I had gotten flash recognized b4 when using a Mandrake distro)
>  Eureka! working flash drive that is seen and formatable with no
> troubles. PLEASE have the developers take a closer look at the IDE
> drivers for 2.4 as it seems they cause a great deal of grief, at 
> least from what I see in searchs on these errors. Usually the problem
> is blamed on the user and they are asked hundreds of irritating questions about hardware and configuration.
> 
> Regards,
> 
> John Sims
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


