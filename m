Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVEZJpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVEZJpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEZJnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:43:49 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:47504 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261297AbVEZJmy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:42:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A7fNQVGGSGVSwq6R4fLK6nE5ABrcGPhpVJUWoI9fu/WTmh6h4LNyNOA3YNf8rU/mlEsBAGd6eszql1oywxBbnMlllhSrqvkVaOYX6oN1oxuBrE3DQgcS7TMx9n9aUA3iCcIhe84Iq0U1L8mY4bwZ6c4D3U3Fk+b/6FvDpdF5u6E=
Message-ID: <187e0cd605052602421b0ebe06@mail.gmail.com>
Date: Thu, 26 May 2005 11:42:54 +0200
From: "Aurelien B." <kerusursaone@gmail.com>
Reply-To: "Aurelien B." <kerusursaone@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2*: CD recorder problem
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20050525223057.051c5572.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504131837.42930.rjw@sisk.pl>
	 <20050525223057.051c5572.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i also have that kind of pb with ide-scsi, k3b detects my dvd burner
one time and if i use the drive (or try to use it), dvd burner is no
longer recognized.
i have the pb with 2.6.12-rc4 and rc5.
(i have to use ide-scsi if i want burning speed better than 1x ...)

2005/5/26, Andrew Morton <akpm@osdl.org>:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Hi,
> >
> > On the kernels above and including 2.6.12-rc2 k3b is unable to operate my
> > IDE CD recorder.  First time (after a fresh reboot) I start it, it detects the
> > recorder properly, but then it refuses to work (it says the media is unknown).
> > After k3b is restarted, it can't even detect the drive.
> >
> > The problem does not occur on 2.6.11.  I don't know whether it happens for the
> > kernels between 2.6.11 and 2.6.12-rc2, but I can check if that's necessary.
> >
> 
> Is this still happening in 2.6.12-rc5?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
