Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRB1FSV>; Wed, 28 Feb 2001 00:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbRB1FSC>; Wed, 28 Feb 2001 00:18:02 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:63503 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S130064AbRB1FR4>;
	Wed, 28 Feb 2001 00:17:56 -0500
Date: Tue, 27 Feb 2001 23:24:40 -0600
To: "Manfred H. Winter" <mahowi@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.2-ac5] X (4.0.1) crashes
Message-ID: <20010227232440.A9376@austin.rr.com>
In-Reply-To: <20010227150830.A739@marvin.mahowi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227150830.A739@marvin.mahowi.de>; from mahowi@gmx.net on Tue, Feb 27, 2001 at 03:08:30PM +0100
From: Erik DeBill <edebill@austin.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having no problems with 2.4.2-ac6, using XFree86 4.0.2 and the
included nv (nvidia) driver.  Works great with my geForce2 GTS,
without any binary only drivers.  4.0.2 seemed to have improved
support for nvidia chips.

If it's any help, I'm also using the rivafb for console (although not
for X).


Erik


On Tue, Feb 27, 2001 at 03:08:30PM +0100, Manfred H. Winter wrote:
> Hi!
> 
> Yesterday I've upgraded my 2.4.2 kernel to ac5, because loop-device
> seems not to work in plain 2.4.2. But now my X-server crashes.
> 
> When I start with startx, X comes up, gnome starts, sawfish starts. Then
> the system freezes. Even SysRQ-keys don't work.
> 
> I use XFree86 4.0.1 with nvidia-drivers 0.96.
> 
> I can't find anything about the crash in the logs, even the output from
> X doesn't get written to disk.
> 
> Is this a known problem?
> 
> I'm going back to vanilla 2.4.2 for now. Is there another way to get
> loop to work?
> 
> Bye,
> 
> Manfred
> -- 
>  /"\                        | PGP-Key available at Public Key Servers
>  \ /  ASCII ribbon campaign | or at "http://www.mahowi.de/"
>   X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
>  / \  and postings          | GPG: 0x88BC3576 * ICQ: 61597169
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
