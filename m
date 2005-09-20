Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVITXLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVITXLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVITXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:11:07 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:3972 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbVITXLF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:11:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcVJsLMmkfvDDPA0AK2C3d3xnaCV3X+1Qnkbuv1DGZT/78o9HgM91CslKWmZzE4IScIPRQxvhJnqpt7Z4Vql55Btxfcdb9EBherWAzcjDj1VIrPJ/s1ZnWPcnUbAPCehD4nH9Z07R2AiFRYYw8owFTaVm6ZYv/fjVvKjZuJvGr0=
Message-ID: <29495f1d0509201611196a88c3@mail.gmail.com>
Date: Tue, 20 Sep 2005 16:11:04 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: Arrr! Linux v2.6.14-rc2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@hansenpartnership.com>
In-Reply-To: <635500000.1127257400@flay>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
	 <635500000.1127257400@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
> > Ahoy landlubbers!
> >
> > Here be t' Linux-2.6.14-rc2 release.
> >
> > Not a whole lot o' excitement, ye scurvy dogs, but it has t' ALSA, LSM,
> > audit and watchdog merges that be missed from -rc1, and a merge series
> > with Andrew. But on t' whole pretty reasonable - you can see t' details in
> > the shortlog (appended).
> >
> > Arrr!
>
> SCSI is broken in several cases by a lack of the patch below, which means
> some of the regular test boxes can't - James, any chance of getting that
> one upstream? (it's cut and pasted, but then you wouldn't want to apply
> it anyway without correct "flow" ;-)).

FYI, test.kernel.org was able to verify this because 2.6.14-rc2 is
available via ftp, even though the website and git (maybe I'm not
using it correctly) don't seem to be updated yet.

Thanks,
Nish
