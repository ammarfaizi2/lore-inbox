Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbTF2JTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 05:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbTF2JTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 05:19:35 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16907
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265612AbTF2JTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 05:19:34 -0400
Date: Sun, 29 Jun 2003 02:30:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <20030629081447.GC29233@lug-owl.de>
Message-ID: <Pine.LNX.4.10.10306290229280.2711-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You missed a point.

Defaulting to off means stablity for the masses.
Enduser enable is for testing to get it correct.
Regardless, it was my $0.02 for the thread.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 29 Jun 2003, Jan-Benedict Glaw wrote:

> On Sat, 2003-06-28 19:17:53 -0700, Andre Hedrick <andre@linux-ide.org>
> wrote in message <Pine.LNX.4.10.10306281917040.1116-100000@master.linux-ide.org>:
> > 
> > The best rule is to default it off and let the end user enable regardless.
> > Thus the default will NEVER encounter the issues seen now.
> 
> While I was the one who initially had the "trouble", I was thankful for
> having a "Switch It On by Default" option. I don't exactly know what the
> patch did to the IDE subsystem (personally I'm not really into IDE...),
> but I'd unhide a problem (either my dumb drive/controller setup or a bug
> in Linux' IDE code) and so - one more bug down (at least from my point
> of view). That's a good thing, IMHO.
> 
> This *is* why I'm using 2.5.x - there's actually a chance to easily find
> bugs with everybody's hardware:)
> 
> MfG, JBG
> 
> -- 
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>       ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));
> 

