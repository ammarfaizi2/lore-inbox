Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289627AbSBJNo7>; Sun, 10 Feb 2002 08:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289628AbSBJNot>; Sun, 10 Feb 2002 08:44:49 -0500
Received: from www.contentmedia.de ([213.61.138.91]:35001 "HELO
	www.contentmedia.de") by vger.kernel.org with SMTP
	id <S289627AbSBJNof> convert rfc822-to-8bit; Sun, 10 Feb 2002 08:44:35 -0500
Subject: Re: funny console prob w/2.4.18-pre[479]+kpreempt+sched-o(1)
From: Marc Recht <recht@contentmedia.de>
To: =?ISO-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C66743C.9BA03219@folkwang-hochschule.de>
In-Reply-To: <3C66743C.9BA03219@folkwang-hochschule.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.2 
Date: 10 Feb 2002 14:44:49 +0100
Message-Id: <1013348690.492.40.camel@leeloo>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Son, 2002-02-10 um 14.23 schrieb Jörn Nettingsmeier:
> hello *
> 
> it happens to me regularly that the x server dies without any
> obvious reason.
[...]
> any clues ?

> i'm using x version 4.2.0 with a voodoo3 card (dri and agp enabled).
> this is an smp box with 2 p3/600 katmai.
> might this be not a kernel issue, but an x11 problem ?
Works for me with, 2.418pre9+kpreempt + sched o(1) (K3) on UP Athlon,
XFree 4.2.0/Geforce with NVidia driver.

Maybe this is a SMP problem ? 

