Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbTCSOo7>; Wed, 19 Mar 2003 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbTCSOo7>; Wed, 19 Mar 2003 09:44:59 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:50333 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263064AbTCSOo6>;
	Wed, 19 Mar 2003 09:44:58 -0500
Date: Wed, 19 Mar 2003 15:55:37 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrus <andrus@members.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED UNTILL NOW!)
Message-ID: <20030319145537.GB25934@h55p111.delphi.afb.lu.se>
References: <000001c2ee1f$02da6820$0100a8c0@andrus> <1048087625.30750.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048087625.30750.34.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18veyf-0000GV-00*Sm.KDI5Zq8c* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 03:27:05PM +0000, Alan Cox wrote:
> On Wed, 2003-03-19 at 13:54, Andrus wrote:
> > You can download working exploit on
> > http://www.members.ee/ptrace-exploit.c
> > 
> > Its hell long exploit as I know, and still not patched!
> 
> The ptrace problems I'm aware of are fixed in 2.2.25 or by the patch
> to 2.4.21pre5-ac I posted (I meant to post the 2.4.20 one, someone
> has since done that).

If access can't be shut down while compiling the new kernel 

echo /foo/bar/doesnotexist >/proc/sys/kernel/modprobe

would help, wouldn't it?

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
