Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267851AbTBEIHx>; Wed, 5 Feb 2003 03:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbTBEIHx>; Wed, 5 Feb 2003 03:07:53 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:61961 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267851AbTBEIHw>; Wed, 5 Feb 2003 03:07:52 -0500
Date: Wed, 05 Feb 2003 01:15:21 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: vda@port.imtp.ilyichevsk.odessa.ua,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 still can't detect my SCSI disk
Message-ID: <1470960000.1044432921@aslan.scsiguy.com>
In-Reply-To: <200302050738.h157c5s16708@Port.imtp.ilyichevsk.odessa.ua>
References: <200302050738.h157c5s16708@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/3.0.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Marcelo,
> 
> I had to find out why 2.4.19 did not work with one old EISA SCSI disk.
> As it turned out, it's an identification problem only. I made a patch
> which works for me, machine is a mail server and now
> I have no problems with disks.
> 
> I sent the patch to Justin T. Gibbs, he said he will test it
> and push to you.

I've tried to get Marcello to update the aic7xxx driver in the 2.4.X
tree to no avail.  The Olvetti support was added to my version of
the aic7xxx driver some time ago.  You can get my latest driver
versions from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

