Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWGCSEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWGCSEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGCSEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:04:52 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:61314 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751229AbWGCSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:04:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O2iqgpxLfpk7RiP7YzhkCaTuyqv8KkrmcjxNvfgG+HGaub8UIlqmHlrS5rl54z6B97ZMJIyHcPHnp/JCrml8KJI4Ejz4VcI5ac+kj9HLfglNIOa8+8w5rtESZSC/wFak9WBpBereK5QuVruwCqWTRker3JnxS6EtHPSHMmbaTN4=
Message-ID: <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
Date: Mon, 3 Jul 2006 14:04:50 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alon !
Unfortunately I don't have an accessible thinkpad laptop (luckly the
external usb devices may work the same way). From the USB readers at
http://www.upek.com/products/usb.asp, which one do you think that fits
better the hardware on your laptop ?

I was looking for any place that sells those devices and I could not
find any online (even though I found lots of SDK and matching engines
that supports them, like VeriFinger).

Is there any place where I can buy one of those readers ?

Daniel

On 7/3/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> On 7/3/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
> > Hello everybody.
> >
> > I would like to develop a driver for any kind of fingerprint reader
> > that currently doesn't have a driver for linux, and I'm open for
> > suggestions on which device I should use. My first thought was the
> > microsoft usb fingerprint reader
> > (http://www.geeks.com/details.asp?invtid=DG2-00002-DT&cpc=SCH) because
> > it's a new device (and, of course, doesn't have any driver for linux),
> > it's cheap, and it's from MS (read "would be fun" =)
>
> Please consider UPEK reader.
> It is available on all new Thinkpad laptops, and the vendor provides
> only binary drivers.
>
> http://www.upek.com/support/dl_linux_bsp.asp
>
> I hate when vendors like ATI, Conexant and UPEK publish binary drivers
> without publishing the chipset spec... They should decide whether
> their IP is on the software part or on the hardware part, if it is on
> the hardware part, they are making money in selling the hardware. If
> it is on the software part, there is no reason why not providing the
> information for others to write software to work with the primitive
> hardware. So in either case there should be full hardware interface
> disclosure.
>
> Best Regards and Goodluck!
> Alon Bar-Lev.
>


-- 
What this world needs is a good five-dollar plasma weapon.
