Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVBFMpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVBFMpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBFMpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:45:43 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:58105 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbVBFMpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:45:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=H7xDmpjd/vaWCURF4il0p3s+yJShMRMbCEyc2phbdOOdytxFLwxfQ+Xu+q1lpY9ltvx78m9Dewf3ZCtqHrojwqn9qKw8ars4wPaRCaYibLIFR3CpTKX2QzC2hFc8RFcdWfV7YA36OxKuhwaeAQmiTacHqIX/TOkitMGV9LU21IE=
Message-ID: <58cb370e050206044513eb7f89@mail.gmail.com>
Date: Sun, 6 Feb 2005 13:45:38 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Cc: Jeff Garzik <jgarzik@pobox.com>, Martins Krikis <mkrikis@yahoo.com>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <1107682076.22680.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>
	 <1107682076.22680.58.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2005 10:27:56 +0100, Arjan van de Ven
<arjan@infradead.org> wrote:
> On Sat, 2005-02-05 at 21:36 -0500, Jeff Garzik wrote:
> > Martins Krikis wrote:
> > > Version 0.1.5 of the Intel Sofware RAID driver (iswraid) is now
> > > available for the 2.4 series kernels at
> > > http://prdownloads.sourceforge.net/iswraid/2.4.29-iswraid.patch.gz?download
> >
> > ACK from me
> 
>  personally I consider it a new feature, and I don't consider new
> features like this appropriate for a 2.4 deep maintenance stream.

I have the same opinion
