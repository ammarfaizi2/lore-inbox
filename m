Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263941AbTCWVss>; Sun, 23 Mar 2003 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263945AbTCWVss>; Sun, 23 Mar 2003 16:48:48 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52221 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263941AbTCWVsp>; Sun, 23 Mar 2003 16:48:45 -0500
Date: Sun, 23 Mar 2003 21:59:46 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323215946.A32478@devserv.devel.redhat.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <3E7E2D7E.7000406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E7E2D7E.7000406@pobox.com>; from jgarzik@pobox.com on Sun, Mar 23, 2003 at 04:56:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 04:56:14PM -0500, Jeff Garzik wrote:
> Martin Mares wrote:
> > Do you really think that "People should either use vendor kernels or
> > read LKML and be able to gather the fixes from there themselves" is a
> > good strategy?
> 
> 
> Maybe I can make the point another way...
> TANSTAAFL:  There Ain't No Such Thing As A Free Lunch.
> 
> Marcelo is a volunteer, and maintaining the 2.4 kernel is not his full 
> time job.  Marcelo isn't beholden to people demanding a kernel release 
> NOW NOW NOW.  If you want that type of support, you have to pay for it.

I know this can sound a bit "the wrong way".

There's another thing though; Marcelo needs to merge the RIGHT fix. And he
did merge it; he just hasn't finished releasing -pre6 yet
