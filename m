Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTABXCs>; Thu, 2 Jan 2003 18:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTABXCs>; Thu, 2 Jan 2003 18:02:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3337 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266064AbTABXCr>;
	Thu, 2 Jan 2003 18:02:47 -0500
Message-ID: <3E14C6D4.1040506@pobox.com>
Date: Thu, 02 Jan 2003 18:10:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Tomas Szepe <szepe@pinerecords.com>,
       Linus Torvalds <torvalds@transmeta.com>, zaitcev@redhat.com,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       netfilter-devel@lists.samba.org, phillim2@comcast.net,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
References: <Pine.GSO.4.21.0301022358340.6446-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0301022358340.6446-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> linux-m68k: Should we kill CONFIG_NE2K_ZORRO, or kill CONFIG_ARIADNE2 and
> rename the driver to ne2k-zorro.c?

I'm not linux-m68k, but let me add my small voice in preference to the 
latter, using ne2k-zorro as the name across the board.

If I had my druthers, I would s/pcnet_cs/ne2k_cs/ too...  hmmmmmm  :)

