Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSKGO0a>; Thu, 7 Nov 2002 09:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266569AbSKGO0a>; Thu, 7 Nov 2002 09:26:30 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:2544 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266564AbSKGO03>; Thu, 7 Nov 2002 09:26:29 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> 
References: <1036415133.1106.10.camel@irongate.swansea.linux.org.uk>  <20021104025458.GA3088@zip.com.au> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 14:33:01 +0000
Message-ID: <9668.1036679581@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Buggy PnP bios please provide dmidecode output for that box

We should really have an extra taint flag for 'We have run untrusted BIOS 
code'. 

--
dwmw2


