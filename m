Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbUCGSTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUCGSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:19:14 -0500
Received: from [193.138.115.101] ([193.138.115.101]:30483 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262287AbUCGSTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:19:13 -0500
Date: Sun, 7 Mar 2004 19:15:09 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI CDROM/DVD trouble with 2.6.3 (2.6.2 is fine)
In-Reply-To: <20040307115031.GK23525@suse.de>
Message-ID: <Pine.LNX.4.56.0403071914180.26369@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0403051745430.21208@jju_lnx.backbone.dif.dk>
 <20040307115031.GK23525@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Jens Axboe wrote:

> On Fri, Mar 05 2004, Jesper Juhl wrote:
> >
> > Hi,
> >
> > I'm currently running 2.6.2 on a system with an Adaptec 29160N SCSI
> > controller, an IBM UltraStar Ultra160 SCSI disk, A Plextor SCSI CD writer
> > and a Pioneer SCSI DVD-ROM drive.
> > With 2.6.2 everything functions perfectly (did so with 2.4.x as well) and
> > I have no trouble what-so-ever.  With 2.6.3 it's a completely different
> > matter.
>
> Try 2.6.4-rc, this problem was reported and fixed weeks ago.
>
Just installed 2.6.4-rc2 and it works nicely. Thank you.


--
Jesper Juhl <juhl@dif.dk>
Sysadmin,  Danmarks Idræts-Forbund / Sports Conederation of Denmark
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please     http://www.expita.com/nomime.html
