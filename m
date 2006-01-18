Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWARO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWARO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWARO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:58:25 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:7393 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030302AbWARO6Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:58:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FmdeJ2BNJOf1tPPVc7TXcPLYyFx+uz2R7GiZgcP37vE8hzrSCgB3ZEfaGJYj5Vcr722sS8YdtdcyR3jhEiiRRm430lHwLauECWNLne31HRIxqWSvNSrLEyt/VdY5LcCjaP1SqctVJWBSko11vH7LIvTLx6aXJVvFeSW1Tn7Y3MA=
Message-ID: <728201270601180658k6529c694g297bff1d46ff695f@mail.gmail.com>
Date: Wed, 18 Jan 2006 08:58:22 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: 7eggert@gmx.de
Subject: Re: NFS problem
Cc: Conio sandiago <coniodiago@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1EzDmI-0001X2-EH@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5wdAz-5a0-7@gated-at.bofh.it> <E1EzDmI-0001X2-EH@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Conio sandiago <coniodiago@gmail.com> wrote:
>
> > i am having some problem in having root file system on NFS,
> > i am developing a linux embedded system,. when i have a root file
> > system on a NFS and i try to boot the kernel through a repeater hub ,
> > then the kernel hangs at freeing init memory.
> >
> >  if i connect the board with the PC through a cross cable,
> > then the system works ok.
>

Just a wild guess. Does it have anything with timeout. Probably hub
introduces  delays which causes the hang. Defective cable  does not
seem to be a case to me  otherwise there would not have been any
communication at all.

Thanks
Ram Gupta
