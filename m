Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSEUUkx>; Tue, 21 May 2002 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSEUUkM>; Tue, 21 May 2002 16:40:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5018 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316602AbSEUUjv>;
	Tue, 21 May 2002 16:39:51 -0400
Date: Thu, 16 May 2002 23:10:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020516231057.A116@toy.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com> <3CE4098E.2070808@mandrakesoft.com> <20020516.183102.56532896.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We are going to end up soon with generic devices in 2.5.x
> and we might as well end up with a "struct bus" too, which

We actually had "struct bus" in the past, but we figured it is better to
let devices have subdevices.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

