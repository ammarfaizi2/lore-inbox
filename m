Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTKYShe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTKYShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:37:33 -0500
Received: from snowman.net ([66.93.83.236]:52488 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S262955AbTKYShb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:37:31 -0500
Date: Tue, 25 Nov 2003 13:37:13 -0500 (EST)
From: Nick <nick@snowman.net>
To: Ricky Beam <jfbeam@bluetronic.net>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
In-Reply-To: <Pine.GSO.4.33.0311251054040.13188-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.21.0311251336250.24128-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware dongles.  You need to be a bit creative but it can be done.  Say
on save of the file output it to the hardware dongle with encrypts it with
your private key, then on load of the file it gets decrypted with the
public key, which is available, or some similar scheme.
	Nick

On Tue, 25 Nov 2003, Ricky Beam wrote:

> On Tue, 25 Nov 2003, [iso-8859-1] Måns Rullgård wrote:
> >> About 15 years ago, there were many gaming softwares which were procected,
> (it was more than 15 years ago.)
> >> for example, by checking "gap" between sectors.
> >
> >Can't that be done with a regular floppy drive and some special
> >software?
> 
> Please heed the lessons already learned in the software industry...
> Copy protection doesn't work.  It works about as well as locks on doors
> as it'll keep the honest people honest, and offer a small obstacle to
> the dishonest.
> 
> As others have stated, anything *you* can do with a PC floppy drive, *I*
> can do. (And given this thread, I can probablly do a few things you
> currently cannot.)  Ultimately, any copy protection comes down to
> the software on the floppy.  If the machine can read it to execute it,
> the hacker can read it to remove the checks.  No ammount of hand-waving
> will change that. (That, btw, is why the DMCA, et. al., exist.)
> 
> --Ricky
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

