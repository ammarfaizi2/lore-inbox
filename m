Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290636AbSBLA1L>; Mon, 11 Feb 2002 19:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSBLA1D>; Mon, 11 Feb 2002 19:27:03 -0500
Received: from ns.suse.de ([213.95.15.193]:33040 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290636AbSBLA0q>;
	Mon, 11 Feb 2002 19:26:46 -0500
Date: Tue, 12 Feb 2002 01:24:05 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Robert Love <rml@tech9.net>, Luigi Genoni <kernel@Expansa.sns.it>,
        Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        <LINUX-KERNEL@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <3C685FBA.A9D60B3A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202120120410.11745-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Jeff Garzik wrote:

> >  Exactly the same symptoms, portmap borken, NIS/NFS subsequently fail.
> /etc/nsswitch.conf set up correctly?  /etc/host.conf?

No problems there. This box worked fine on any other kernel,
and that problem only showed up the once..

> I notice that newer RH and MDK initscripts require a bunch of stuff like
> netlink devices and ipv6 support, make sure you have those enabled
> too...

Yup.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

