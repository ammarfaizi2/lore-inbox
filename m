Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRAMVpZ>; Sat, 13 Jan 2001 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAMVpP>; Sat, 13 Jan 2001 16:45:15 -0500
Received: from Cantor.suse.de ([194.112.123.193]:11792 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129652AbRAMVo4>;
	Sat, 13 Jan 2001 16:44:56 -0500
Date: Sat, 13 Jan 2001 22:44:30 +0100
From: Andi Kleen <ak@suse.de>
To: Krzysztof Rusocki <lkml@braxis.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 (w/XFS) & reset_xmit_timer
Message-ID: <20010113224430.A17213@gruyere.muc.suse.de>
In-Reply-To: <20010113221142.A3913@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010113221142.A3913@main.braxis.co.uk>; from lkml@braxis.co.uk on Sat, Jan 13, 2001 at 10:11:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 10:11:42PM +0100, Krzysztof Rusocki wrote:
> 
> Hi,
> 
> Since 2.4.0 (from XFS CVS source tree) i get such things from kernel:
> 
> Jan 13 20:55:48 main kernel: reset_xmit_timer sk=c299b9a0 1 when=0x6061, caller=c0218f88 

It's harmless. Just ignore them or comment out the printk if it bothers
you.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
