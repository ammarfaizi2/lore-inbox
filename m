Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270678AbTG0GBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270680AbTG0GBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:01:50 -0400
Received: from [65.248.106.250] ([65.248.106.250]:4495 "EHLO brianandsara.net")
	by vger.kernel.org with ESMTP id S270678AbTG0GBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:01:49 -0400
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 00:53:14 -0500
User-Agent: KMail/1.5.9
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200307262309.20074.adq_dvb@lidskialf.net> <3F235B73.70701@genebrew.com>
In-Reply-To: <3F235B73.70701@genebrew.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307270053.14649.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 11:56 pm, Rahul Karnik wrote:
> Andrew de Quincey wrote:
> > Small patch for the latest nvidia nforce 1.0-261 nvnet drivers with
> > kernel 2.5.
>
> Further nvnet musings (cc:ing Jeff as net driver maintainer and
> knowledgeable person).
>
> As I reported here a few days earlier, I tried using the AMD8111 driver
> with my NForce2 ethernet a few days ago, with the result that no MAC
> address was being assigned to the card. I suspect that the MAC address
> is being assigned by the Nvidia driver. Does that make sense?
>
> If so, then using the option in the BIOS to manually set the MAC address
> might make the AMD driver work. Unfortunately, I have no idea what I
> should set it to without stomping on the MAC address for other devices.

my mac address is printed on a little sticker on top of the parallel port 
(inside the case) on a leadtek NCR18Gpro(?)

--Brian Jackson

>
> Any ideas? I hate to rely on a binary only module for something as
> "simple" as a 10/100 ethernet card.
>
> Thanks,
> Rahul

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net
