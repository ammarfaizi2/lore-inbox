Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbTCGV1m>; Fri, 7 Mar 2003 16:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbTCGV1m>; Fri, 7 Mar 2003 16:27:42 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:25862 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S261791AbTCGV1l>; Fri, 7 Mar 2003 16:27:41 -0500
Subject: Re: 2.5.64-ac3: 3c527.c doesn't compile
From: James Bottomley <James.Bottomley@steeleye.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030307210323.GD19615@fs.tum.de>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com> 
	<20030307210323.GD19615@fs.tum.de>
Content-Type: multipart/mixed; boundary="=-wgaNFt70SEN1snrtIwQL"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Mar 2003 15:34:52 -0600
Message-Id: <1047072894.3444.22.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wgaNFt70SEN1snrtIwQL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-03-07 at 15:03, Adrian Bunk wrote:
> On Fri, Mar 07, 2003 at 12:56:44PM -0500, Alan Cox wrote:
> 
> >...
> > Linux 2.5.64-ac2
> >...
> > o	Update 3c527 to modern locking (untested)	(James Bottomley)
> >...
> 
> It seems even the compilation is untested?

It builds for me fine in 2.5.64.  Perhaps you misapplied the patch, or
got a mangled one.  The correct patch is below.

James


--=-wgaNFt70SEN1snrtIwQL
Content-Disposition: attachment; filename=tmp.diff
Content-Type: application/octet-stream; name=tmp.diff
Content-Transfer-Encoding: base64


--=-wgaNFt70SEN1snrtIwQL--

