Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbSLKVSG>; Wed, 11 Dec 2002 16:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSLKVSG>; Wed, 11 Dec 2002 16:18:06 -0500
Received: from mail.ithnet.com ([217.64.64.8]:42502 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267288AbSLKVSF>;
	Wed, 11 Dec 2002 16:18:05 -0500
Date: Wed, 11 Dec 2002 22:12:29 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
Message-Id: <20021211221229.5cf94574.skraw@ithnet.com>
In-Reply-To: <1039641834.18587.33.camel@irongate.swansea.linux.org.uk>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
	<1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
	<20021211203403.130fc724.skraw@ithnet.com>
	<1039639993.18587.19.camel@irongate.swansea.linux.org.uk>
	<20021211212734.5429bfee.skraw@ithnet.com>
	<1039641834.18587.33.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2002 21:23:54 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > does not share interrupt with another device. As soon as I share I get
> > busted. As I told the driver used for ethernet doesn't seem to matter as
> > tulip and sundance show the same effect.
> > I am very interested in solving this somehow having five pieces of these
> > boards...
> 
> I would be very interested if (and I've seen this before with other
> vendors boards) plugging the quad card into a good old intel 440BX or
> something like that makes them work.

Hm, I have about 2 dozens of these 4-port cards and had _never_ any troubles in
various backplanes, via, intel, sis...
To me it seems it has something to do with this relatively new chipset...
-- 
Regards,
Stephan

