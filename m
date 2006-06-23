Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWFWMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWFWMrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWFWMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:47:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:21969 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932585AbWFWMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:47:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TFDtt9Sm7zHM3Aig/O5IA1yIQdSJnUUljrO2YAUQmm/YEcfFgoQ3hF1y3oHL82IeLZHfrzLD+edur5kgPr0O7DiXKOy6GF1EytDdiWbUEdEmuVBbiI+/P4GF06G5QxQ7u9CZuecSgkad6+sR0lDn9EaQvRILJ0y4zDeENoXasFQ=
Message-ID: <e6ec3ad10606230547g461aabaao4fb92eebdf2d14a2@mail.gmail.com>
Date: Fri, 23 Jun 2006 14:47:36 +0200
From: "Marcin Juszkiewicz" <openembedded@hrw.one.pl>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: sharp zaurus sl-5500 (collie): touchscreen now works
Cc: "Richard Purdie" <rpurdie@rpsys.net>, lenz@cs.wisc.edu,
       "kernel list" <linux-kernel@vger.kernel.org>, metan@seznam.cz,
       arminlitzel@web.de, "Dirk Opfer" <Dirk@opfer-online.de>
In-Reply-To: <20060623104836.GG5343@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610202541.GA26697@elf.ucw.cz>
	 <1150139307.5376.56.camel@localhost.localdomain>
	 <20060614232814.GJ7751@elf.ucw.cz>
	 <1150329342.9240.38.camel@localhost.localdomain>
	 <e6ec3ad10606230320s25596353y7b238593b90051f5@mail.gmail.com>
	 <20060623104836.GG5343@elf.ucw.cz>
X-Google-Sender-Auth: 8a3cac023d6ba94a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/06, Pavel Machek <pavel@suse.cz> wrote:

> > >Zaurus SL-5500 MMC/SDIO technical info

> Do you have any contact to author of this? It lacks any copyright/GPL
> info :-(.

No info about author.

>  Is wrt54g also sa1100-based?

wrt54g is MIPS powered:
root@OpenWrt:~# cat /proc/cpuinfo
system type             : Broadcom BCM947XX
processor               : 0
cpu model               : BCM3302 V0.7
BogoMIPS                : 215.44

> > Maybe this will help.

> Yes, thanks a lot.

Visit #oe on freenode IRC network sometimes - Zaurus kernel.
discussion are more often there.
