Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWJ2Gw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWJ2Gw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 01:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWJ2Gw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 01:52:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:33128 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965092AbWJ2Gw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 01:52:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ns/sSIAaZXTx0Gypv/MxWjFFJC2e3Rlrqzzv/L21jl61u5Fl/hSibqBgpfs0X5g3QA9hJgSLVl6Xa6PBkyF+1IKO/njP4xIPecgDF7D/2oT9kPsxxtbmIZf43R3DrICvtsAa9tRVNPaTiBpuNmDTBpGjdTSO7p7Ld01Blt8GCc0=
Message-ID: <b637ec0b0610282352y7a6d2fdap8fbcbac5be20b48b@mail.gmail.com>
Date: Sun, 29 Oct 2006 07:52:56 +0100
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Alex Dubov" <oakad@yahoo.com>
Subject: Re: [2.6.19-rc2-mm2] oops removing sd card
Cc: "Pierre Ossman" <drzeus-mmc@drzeus.cx>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45431257.8080401@drzeus.cx>
	 <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can only confirm that this problem is 2.6.19-rc related. If you have
patches to test please let me know.

Fabio






On 10/29/06, Alex Dubov <oakad@yahoo.com> wrote:
> I know that this is unfortunate, but I, currently, don't have an ability to put 2.6.19 kernel on a
> machine with ti controller. I have not seen this problem on 2.6.18, so I'm out of ideas.
>
> --- Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
>
> > Fabio Comolli wrote:
> > > More info: I tried to use tifm_core.c and tifm_71xx.c from 2.6.18-mm3
> > > with 2.6.19-rc2-mm2 and the crash also happens.
> > >
> >
> > Alex, have you followed up this? I haven't seen any replies.
> >
> > Rgds
> > --
> >      -- Pierre Ossman
> >
> >   Linux kernel, MMC maintainer        http://www.kernel.org
> >   PulseAudio, core developer          http://pulseaudio.org
> >   rdesktop, core developer          http://www.rdesktop.org
> >
>
>
>
>
> ____________________________________________________________________________________
> Access over 1 million songs - Yahoo! Music Unlimited
> (http://music.yahoo.com/unlimited)
>
>
