Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVAGCXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVAGCXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVAGCXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:23:41 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:33809 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261190AbVAGCU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:20:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ryySxl4B45850C5rinfABx7ANAtfucC3ao43zxGOXNPEOYmOK4NKXZ9TlmKNGLF1xoc007clI2LOl2aZjyzEZJ1eLcKB58XhYd7PB1phvla0hlYfZ3Tr9qrzTNMqbxmPesdox9/79tsfjclV5auT+cbGJsvq/ECcODwY9TYNavw=
Message-ID: <58cb370e050106182058241abc@mail.gmail.com>
Date: Fri, 7 Jan 2005 03:20:59 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Robitaille <robitaille@gmail.com>
Subject: Re: CD-ROM ide-dma blacklist amnesty drive
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e453abbe05010300424d652b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e453abbe05010300424d652b7a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005 00:42:43 -0800, Daniel Robitaille
<robitaille@gmail.com> wrote:
> > The following is a list of CD drives blacklisted (I've removed
> > hard-disks and flash from the list) in drivers/ide/ide-dma.c as
> > of 2.6.10-rc3:
> >
> > CRD-8480C
> >
> > If (1) you are a owner of one of the listed drives, and (2) you
> > know your drive works fine with DMA, please speak up.
> > It would especially be a big plus if your drive is on via82cxxx
> > and did not have any trouble running it with DMA before 2.6.8.
> 
> I have used a CRD-8480C with DMA on 2.6.8 without any problems.

thanks, drive removed from the blacklist
