Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKNT3s>; Thu, 14 Nov 2002 14:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSKNT3s>; Thu, 14 Nov 2002 14:29:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262871AbSKNT3r>;
	Thu, 14 Nov 2002 14:29:47 -0500
Message-ID: <3DD3FB29.6020504@pobox.com>
Date: Thu, 14 Nov 2002 14:36:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <225710000.1037241209@flay> <mailman.1037294313.19087.linux-kernel2news@redhat.com> <200211141912.gAEJCwH01539@devserv.devel.redhat.com>
In-Reply-To: <225710000.1037241209@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> >>The bugzilla database we proposed earlier is now available for
> >>use, hosted by OSDL.
> >>
> >>http://bugme.osdl.org
> >
> >I forgot to mention, it would IMO speed acceptance and increase usage if
> >this was a vendor-neutral URL, like 'bugzilla.kernel.org'...
>
>
> OSDL is vendor neutral, by definition. Besides, we all know
> that Transmeta hosts ftp.kernel.org and Red Hat hosts vger
> (for varying definitions of "hosts", but you know what I mean).
> I do not see acceptance suffer, because we do not observe
> Transmeta or Red Hat pushing their agendas. Same with OSDL.


Sure, but vger and ftp are both suffixed with "kernel.org"   If 
Transmeta or Red Hat ever flake out, it's easier to redirect the domain 
to some other machine.

If nothing else it's consistent naming that keeps with the Principle of 
Least Surprise :)

> I'm more interested in contacting the admin to be a component
> owner for sparc, for instance. Someone is going to have a significant
> admin load, because Bugzilla is not going to be self-running.
> Who is that person?


Check out Martin's original announcement, as well as his recent one. 
I'm pretty pleased:  they have staff that will help triage bugs and keep 
the garbage level low.  Hopefully leaving the kernel hackers to do 
nothing more than fix bugs :)

	Jeff


