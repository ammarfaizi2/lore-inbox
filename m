Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbULCETt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbULCETt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 23:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbULCETt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 23:19:49 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:10461 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S261941AbULCETr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 23:19:47 -0500
Date: Thu, 2 Dec 2004 22:19:43 -0600
From: John Lash <jlash@speakeasy.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma errors with sata_sil and Seagate disk
Message-ID: <20041202221943.3d19590d@tux>
In-Reply-To: <yw1xvfbkrxn0.fsf@ford.inprovide.com>
References: <20041201115045.3ab20e03@homer.sarvega.com>
	<1101944482.30990.74.camel@localhost.localdomain>
	<yw1xpt1tuihe.fsf@ford.inprovide.com>
	<1102030431.7175.9.camel@localhost.localdomain>
	<yw1xvfbkrxn0.fsf@ford.inprovide.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs126 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2004 02:14:27 +0100
Måns Rullgård <mru@inprovide.com> wrote:

> Alan Cox <alan@lxorguk.ukuu.org.ak> writes:
> 
> > On Iau, 2004-12-02 at 10:01, Måns Rullgård wrote:

> Does this mean it is the drives which are faulty, not the controller?
> These drives are both new, so I suppose known problems might have been
> fixed.  FWIW, they are reported by the kernel thusly:
> 
>   Vendor: ATA       Model: ST3160827AS       Rev: 3.03
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST3160827AS       Rev: 3.00
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> 

I know that the disk that I'm using has been sitting on a shelf since about last June. It still
seems to be a shipping model though. It's showing itself as model: ST380013AS, rev: 3.18. 

It would be nice if the problem gets fixed someday. Be even nicer if there was a firmware update
that could be applied to the older drives.....

--john
