Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270159AbRHRN3b>; Sat, 18 Aug 2001 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRHRN3V>; Sat, 18 Aug 2001 09:29:21 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:26051 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S270154AbRHRN3N> convert rfc822-to-8bit; Sat, 18 Aug 2001 09:29:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andy Stewart <andystewart@mediaone.net>
Organization: Worcester Linux Users' Group
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.4.9 locks up solidly with USB and SMP
Date: Sat, 18 Aug 2001 09:26:12 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, andystewart@mediaone.net
In-Reply-To: <E15Y4yJ-0000p0-00@the-village.bc.nu>
In-Reply-To: <E15Y4yJ-0000p0-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01081809261200.01856@tux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 August 2001 08:12, Alan Cox wrote:
> > SMP without USB seems to work properly.  USB in uniprocessor mode is
> > also working properly.
> >
> > I have usbcore and usb-uhci loaded as modules.
>
> Use the uhci module instead and it ought to be better

Using the uhci module has indeed solved the problem.

Thank you!

--
Andy Stewart
Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

