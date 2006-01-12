Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWALOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWALOyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWALOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:54:04 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:4843 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1030432AbWALOyC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:54:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WVJLP95bFqX2W86v1z/LfEDTDAWeXm4/tWP639Pny+ym8WCoQlG+UWUVsoIL2qI1lT8bjii+vOTgCCVR+y9W+C13ngIzkvItloj3WMzQIjHSP9qxpaPtTrw2yGOsE+fgpY6o2XqJKJhsjjqvH4w0Q+3nRxVXQZR6ScYsP4i++Hc=
Message-ID: <728201270601120652g21c8b2d5t340cf01f7c0d91fc@mail.gmail.com>
Date: Thu, 12 Jan 2006 08:52:20 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Reinhold Jordan <r.jordan@asc.de>
Subject: Re: option memmap
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43C62818.6030001@asc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C51ABD.4050204@asc.de> <43C62818.6030001@asc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Reinhold Jordan <r.jordan@asc.de> wrote:
> Hello,
>
> is there any problem with this question? Who should I ask
> kernel dependent questions beside the kernel developers?
>
> Regards, Reinhold
>
> Reinhold Jordan wrote:
> > Hello,
> >
> > is there any documentation for this option better than this in
> > linux/Documentation/kernel-parameters.txt ?
> >
> > I have a laptop with a defect memory soldered on the main-board.
> > 128KB of 128MB are defect started at 7936KB
> >

Did you use memmap option in combination with mem option.mem option is
used to specify the amount of memory to be used & memmap specifies the
region map.

regards
Ram Gupta
