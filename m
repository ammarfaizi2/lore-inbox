Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbTC0Lnq>; Thu, 27 Mar 2003 06:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbTC0Lnq>; Thu, 27 Mar 2003 06:43:46 -0500
Received: from [81.2.110.254] ([81.2.110.254]:26101 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261930AbTC0Lnp>;
	Thu, 27 Mar 2003 06:43:45 -0500
Subject: Re: Linux 2.4.21-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0303271140160.26358-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303271140160.26358-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048766169.2606.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 11:56:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 10:42, Geert Uytterhoeven wrote:
> On Wed, 26 Mar 2003, Marcelo Tosatti wrote:
> > Here goes -pre6.
> > 
> > We are approaching -rc stage. I plan to release -pre7 shortly which should
> > fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.
> 
> Is IDE in 2.4.x and 2.5.x now more or less in sync?

At the driver level yes, some of the upper core stuff is very different because
2.5 is rather different.

Alan

