Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271712AbTHMJ3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271730AbTHMJ3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:29:47 -0400
Received: from mail.gondor.com ([212.117.64.182]:30728 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S271712AbTHMJ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:29:47 -0400
Date: Wed, 13 Aug 2003 11:25:36 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813092536.GA7034@gondor.com>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813080309.GB2006@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813080309.GB2006@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 10:03:09AM +0200, Jan Niehusmann wrote:
> right?), and hdparm -I /dev/hde completely locks up the whole computer -

Looks like this problem has been described here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104250818527780&w=2

I'll try the patch this evening...

Why does promise IDE always have some strange problems?

Jan

