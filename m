Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTBRAgk>; Mon, 17 Feb 2003 19:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBRAgk>; Mon, 17 Feb 2003 19:36:40 -0500
Received: from tapu.f00f.org ([202.49.232.129]:28558 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267243AbTBRAgj>;
	Mon, 17 Feb 2003 19:36:39 -0500
Date: Mon, 17 Feb 2003 16:46:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218004639.GA7573@f00f.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <20030218000304.GA7352@f00f.org> <3E5181D8.6040109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5181D8.6040109@pobox.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 07:44:08PM -0500, Jeff Garzik wrote:

> ACPI, or no?

nope

> highmem, or no?

no for me --- yes for them I assume (8-way P4)

> Are you running your UP Athlon with CONFIG_X86_UP_APIC?

I was... I wondered if that might do it, so I tried without.  Still
reboots.  Built kernel as 486 kernel with no IO-APIC too, still
reboots.

Nothing is logged (serial console).

Tried gcc-2.95 and gcc-3.2.



  --cw
