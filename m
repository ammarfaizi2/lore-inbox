Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWJZWZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWJZWZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWJZWZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:25:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161393AbWJZWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:25:27 -0400
Date: Fri, 27 Oct 2006 00:25:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device changes]
Message-ID: <20061026222525.GP27968@stusta.de>
References: <4540F79C.7070705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540F79C.7070705@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 07:59:56PM +0200, Jiri Slaby wrote:
>...
> And what about (E)ISA support. When converting to pci probing, should be ISA bus
> support preserved (how much is ISA used in present)? -- it makes code ugly and long.

There seem to be still many running 486 machines - and only the last 486 
boards also had PCI slots.

While deprecating OSS drivers, I got emails from people still using some 
of the ISA cards.

And there are even Pentium 4 boards with ISA slots available.

> regards,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

