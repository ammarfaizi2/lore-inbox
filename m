Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031753AbWLATcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031753AbWLATcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031755AbWLATcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:32:32 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:59278 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1031753AbWLATcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:32:31 -0500
Date: Fri, 1 Dec 2006 20:32:30 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.19 VServer 2.1.x
Message-ID: <20061201193230.GA544@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Linux Containers <containers@lists.osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061201022904.GP2826@MAIL.13thfloor.at> <457004DF.7030100@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457004DF.7030100@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 01:33:03PM +0300, Kirill Korotaev wrote:
> OpenVZ has been using them for more than a month already ;-)

great for you, here some details:

 - 2.6.19 was released 29th Nov 2006
 - OpenVZ page shows 2.6.9-023, 2.6.16 and the 
   2.6.18 development
 - Linux-VServer has followed the -rc series
   too, so that's nothing new
 - I didn't manage to find an OpenVZ patch for
   2.6.19 on your site

but probably all the changes from 2.6.19 have
been backported to the stable 2.6.9 kernel
several months ago :)

best,
Herbert

> Kirill
> 
> > Ladies and Gentlemen!
> > 
> > here is the first Linux-VServer version (testing)
> > with support for the *spaces (uts, ipc and vfs)
> > introduced in 2.6.19 ...
> > 
> > http://vserver.13thfloor.at/Experimental/patch-2.6.19-vs2.1.x-t1.diff
> > 
> > it might not be as perfect as the kernel itself *G*
> > but it does work fine here, and with recent tools
> > most virtualization features work as expected
> > 
> > please if you do testing, report issues or comments
> > to the Linux-VServer mailing list or to me directly
> > (at least CC would be fine) and do not bother the
> > nice kernel folks ...
> > 
> > enjoy,
> > Herbert
> > _______________________________________________
> > Containers mailing list
> > Containers@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/containers
> > 
> > 
