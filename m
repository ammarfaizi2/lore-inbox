Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCZWL7>; Mon, 26 Mar 2001 17:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCZWLu>; Mon, 26 Mar 2001 17:11:50 -0500
Received: from [213.96.224.204] ([213.96.224.204]:28932 "HELO man.beta.es")
	by vger.kernel.org with SMTP id <S129466AbRCZWKB>;
	Mon, 26 Mar 2001 17:10:01 -0500
Date: Tue, 27 Mar 2001 00:08:43 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Wake on LAN
Message-ID: <20010327000843.A2230@manty.net>
In-Reply-To: <20010326210846.A1182@manty.net> <3ABF95F8.84508E68@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABF95F8.84508E68@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 26, 2001 at 02:18:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you using Becker's ftp://www.scyld.com/pub/diag/ether-wake.c ?

Yes.

> Did you turn on the enable_wol module option?  Note that might be a new
> option in the 2.4.3-preXX series...

Well, it is indeed a 2.4.3-pre feature, as I had looked for it on 2.4.2, it
was not there, but it is at least on pre8.

This new driver allows me to WOL, but only if I don't choose ACPI, if I
choose ACPI then I have the same problem as with 2.4.2. APM works ok though.

Thanks for your help, now I'm gonna ask the ACPI guys about this.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
