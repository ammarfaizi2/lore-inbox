Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292467AbSCIGhC>; Sat, 9 Mar 2002 01:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292468AbSCIGgw>; Sat, 9 Mar 2002 01:36:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36048 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292467AbSCIGgc>; Sat, 9 Mar 2002 01:36:32 -0500
Message-Id: <200203090636.g296aSV273332@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.1 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: "Jeff Jenkins" <jefreyr@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Thread registers dumped to core-file
Date: Sat, 09 Mar 2002 12:15:49 +0530
In-Reply-To: <HFEPKLGPJDEHEGCKLKCCMEDLCCAA.jefreyr@pacbell.net>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is an email copy of a Usenet post to "mailinglists.external.linux-kernel"]

We are working on dumping the register state (including FPU and SSE regs)
of all threads to the elf core file. We should release the patch fairly
soon.

Vamsi Krishna S.
Linux Technology Center
IBM Software Labs, Bangalore, India

On Fri, 08 Mar 2002 21:52:48 +0530, Jeff Jenkins wrote:

> I was chatting with the GDB folks, and they mentioned there is no code in the
> kernel which
> will dump *all* thread registers to a core file.  Anyone have such code that
> could be used in a patch?
> 
> Being able to get at the state of all threads in a process at core-dump time is
> invaluable!
> Anyone else been griping about this?
> 
> Rah!
> 
> -- jrj
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html Please read the FAQ at
> http://www.tux.org/lkml/
>
