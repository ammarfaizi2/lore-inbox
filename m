Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSKGPo2>; Thu, 7 Nov 2002 10:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKGPo1>; Thu, 7 Nov 2002 10:44:27 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:45042 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261312AbSKGPo0>; Thu, 7 Nov 2002 10:44:26 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021107154609.GB25903@suse.de> 
References: <20021107154609.GB25903@suse.de>  <20021107145112.GA24278@suse.de> <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> <20021104025458.GA3088@zip.com.au> <9668.1036679581@passion.cambridge.redhat.com> <11262.1036680930@passion.cambridge.redhat.com> 
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 15:50:59 +0000
Message-ID: <16807.1036684259@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@codemonkey.org.uk said:
>  Crap. The OSS driver works fine, just not as accelerated.

Ah. It must have got a lot better since I last tried it then -- last time I
looked it wouldn't work on the newer chips at all. I had to use the vesa 
driver instead.

>  I don't see what it would buy us. 

It makes it clear that untrusted and undebuggable code is running, just 
like the 'Proprietary' flag does.

--
dwmw2


