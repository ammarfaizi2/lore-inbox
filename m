Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSCUXPd>; Thu, 21 Mar 2002 18:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSCUXPX>; Thu, 21 Mar 2002 18:15:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:45728 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S312560AbSCUXPP>; Thu, 21 Mar 2002 18:15:15 -0500
Date: Thu, 21 Mar 2002 16:30:15 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hari Gadi <HGadi@ecutel.com>, linux-kernel@vger.kernel.org
Subject: Re: module (kernel) debugging
Message-ID: <20020321163015.A25688@vger.timpanogas.org>
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com> <E16oBVq-0006Z6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more:

MDB - source level kernel debugger.  

:-)

Jeff

On Thu, Mar 21, 2002 at 10:58:26PM +0000, Alan Cox wrote:
> > I am new to kernel level development. What are the best ways to debug runtime
> > kernel (module).
> 
> Your brain 8)
> 
> > Are there any third party tools for debugging the kernel.
> 
> Several
> 
> 	kgdb	-	debug the kernel with gdb from another PC
> 	kdb	-	patch for in kernel debugger
> 	UML	-	user mode linux (good for fs not so good for driver
> 			work)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
