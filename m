Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135737AbQKGXn7>; Tue, 7 Nov 2000 18:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135421AbQKGXnF>; Tue, 7 Nov 2000 18:43:05 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:10 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S132954AbQKGXlx>; Tue, 7 Nov 2000 18:41:53 -0500
Date: Tue, 7 Nov 2000 15:35:59 -0800 (PST)
From: Miles Lane <miles@speakeasy.org>
To: David Luyer <david_luyer@pacific.net.au>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test10 and X4.0.1 don't like each other on Libretto
 110CT
In-Reply-To: <200011072329.eA7NTDx17836@typhaon.pacific.net.au>
Message-ID: <Pine.LNX.4.21.0011071534460.7109-100000@grace.speakeasy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You must upgrade to the latest release:  4.0.1e

The fix for this problem went into 4.0.1d, but since you
need to upgrade, you might as well get the latest code.

	Miles

On Wed, 8 Nov 2000, David Luyer wrote:

> 
> I'm having problems with X 4.0.1 and 2.4.0-test kernels on a Toshiba Libretto
> 110CT.  Is this likely to be related to a known problem or can someone
> recommend some random intermediate kernel versions to try (binary elimination
> avoiding known-bad kernel versions...)?
> 
> H/w: Toshiba Libretto 110CT (NM2160), Xircom CEM336 modem/ethernet
> S/w: Debian woody as at Wed Nov 8, with old xserver-svga package for testing
> 
> Kernel                     xserver-xfree86 4.0.1-1    xserver-svga 3.3.6-10
> 2.4.0-test10               Fail                       OK
> 2.4.0-test4pre3            Fail                       OK
> 2.2.15 (Debian build)      OK                         OK
> 
> "Fail" here means X startup results in a blank LCD, unable to switch to 
> text consoles either, SAK results in a screen full of previous graphics-mode
> display on LCD, even if it was pre-reboot, at that screen it is possible to
> type (although not to see the result), login, reboot the system, try a
> different version of X, etc (as long as you can remember what you've typed).
> 
> Thanks for any help,
> David.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
