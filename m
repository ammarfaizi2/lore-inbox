Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262668AbRFBTLA>; Sat, 2 Jun 2001 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbRFBTKt>; Sat, 2 Jun 2001 15:10:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:63759 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262665AbRFBTKo>; Sat, 2 Jun 2001 15:10:44 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B193A24.B41CF6EC@transmeta.com>
Date: Sat, 02 Jun 2001 12:10:28 -0700
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
In-Reply-To: <E156Ggf-00021X-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Let me guess... you're using a RedHat system?  RedHat, for some
> > idiotic reason, defaults to actively turning this off for you (and
> > they turn Stop-A off on SPARC, too.)
> >
> 
> We turn it off by default because its a rather large dangerous security
> hole to leave around when a naiive user makes a basic installation. It is much
> better that it is enabled by someone who knows what they are doing and makes
> the decision to do so. Thats why we contributed the patch to make syrq runtime
> configurable
> 
> Tools like powertweak even give you a nice gui interface for managing it.

Sure, if you know about it and know how to find it!

	-hpa
