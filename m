Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQLUJiA>; Thu, 21 Dec 2000 04:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbQLUJhv>; Thu, 21 Dec 2000 04:37:51 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:33054 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129610AbQLUJhl>; Thu, 21 Dec 2000 04:37:41 -0500
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown PCI device?
In-Reply-To: <Pine.LNX.4.31.0012210401510.748-100000@asdf.capslock.lan>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: 21 Dec 2000 10:07:12 +0100
In-Reply-To: "Mike A. Harris"'s message of "Thu, 21 Dec 2000 04:02:22 -0500 (EST)"
Message-ID: <7yelz2f8hr.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike A. Harris" <mharris@opensourceadvocate.org> writes:

> Anyone know what this is?
> 
> 00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
>         Flags: medium devsel

if its pci id is 0x11063050, then it's a VIA Power Management Controller.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
