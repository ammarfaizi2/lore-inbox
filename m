Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273018AbTHKTLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272988AbTHKTKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:10:43 -0400
Received: from quito.magic.fr ([62.210.158.45]:33781 "EHLO quito.magic.fr")
	by vger.kernel.org with ESMTP id S273323AbTHKTJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:09:12 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: Jocelyn Mayer <l_indien@magic.fr>
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <greg@kroah.com>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030811185633.GA4237@redhat.com>
References: <1060429216.29152.61.camel@jma1.dev.netgem.com>
	 <1060624865.29139.137.camel@jma1.dev.netgem.com>
	 <20030811180703.GA1564@redhat.com> <20030811181414.GB17442@kroah.com>
	 <1060628145.29139.164.camel@jma1.dev.netgem.com>
	 <20030811185633.GA4237@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060629035.29152.175.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Aug 2003 21:10:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 20:56, Dave Jones wrote:
> On Mon, Aug 11, 2003 at 08:55:45PM +0200, Jocelyn Mayer wrote:
> 
>  > > > Did you also compile in any of the AGP chipset drivers?
>  > # CONFIG_AGP_AMD is not set
> 
> That'll be 'no' then 8-)
> Fix this, and everything should start magickally working.
> 
> 		Dave
Ooops... So sorry, I've been caught like a newby, this time !
I though that was VIA chipset... I just checked what I used to
do on 2.4 kernels, and I did use CONFIG_AGP_AMD...
So I got no excuse...

Many thanks to you !

-- 
Jocelyn Mayer <l_indien@magic.fr>

