Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTDWSwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTDWSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:52:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61238 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264285AbTDWSuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:50:52 -0400
Date: Wed, 23 Apr 2003 15:02:47 -0400
From: Bill Nottingham <notting@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 - intel AGP update (rev 3)
Message-ID: <20030423150247.B8931@devserv.devel.redhat.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20030423144947.A8931@devserv.devel.redhat.com> <Pine.SOL.4.30.0304232058190.28155-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.30.0304232058190.28155-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Wed, Apr 23, 2003 at 08:59:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz (B.Zolnierkiewicz@elka.pw.edu.pl) said: 
> > Again, AGP support for i852GM/i855GM/i855PM/i865G. Mostly
>                                        ^^^^^^
> > by David Dawes (<dawes@tungstengraphics.com>)
> >
> > Changes from previous:
> > - remove any support for 'integrated graphics' on i855PM... there's
>                                                     ^^^^^^
> >   no such thing. (oops)
> >
> > Bill
> 
> :-)

It still adds support for the i855PM agp *bridge*.

Bill
