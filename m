Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSKGOs4>; Thu, 7 Nov 2002 09:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266577AbSKGOsz>; Thu, 7 Nov 2002 09:48:55 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:48880 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266576AbSKGOsz>; Thu, 7 Nov 2002 09:48:55 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021107145112.GA24278@suse.de> 
References: <20021107145112.GA24278@suse.de>  <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> <20021104025458.GA3088@zip.com.au> <9668.1036679581@passion.cambridge.redhat.com> 
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 14:55:30 +0000
Message-ID: <11262.1036680930@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@codemonkey.org.uk said:
>  Relatively pointless given that there are more and more boxes out
> there that won't boot without ACPI these days.

There are also more and more boxes out there which won't run X without the
nvidia driver loaded. Does that mean we shouldn't bother to record that 
information either?

I'm not necessarily suggesting we should automatically ignore all reports 
with the 'BIOS' taint flag set as we do the 'Proprietary' flag; just that 
it should be reported.

--
dwmw2


