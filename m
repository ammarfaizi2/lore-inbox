Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbQLIWdR>; Sat, 9 Dec 2000 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131542AbQLIWdI>; Sat, 9 Dec 2000 17:33:08 -0500
Received: from 154.145.126.209.cari.net ([209.126.145.154]:11783 "EHLO
	newportharbornet.com") by vger.kernel.org with ESMTP
	id <S131532AbQLIWct>; Sat, 9 Dec 2000 17:32:49 -0500
Date: Sat, 9 Dec 2000 14:03:08 -0800 (PST)
From: Bob Lorenzini <hwm@ns.newportharbornet.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
In-Reply-To: <20001209154916.A14937@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0012091400590.17164-100000@newportharbornet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Jeff V. Merkey wrote:

> 
> 
> 2.2.18-25 with Frame Buffer enabled will frizt and trash LCD displays
> on DELL laptop computers when the system kicks into graphics mode,
> and attempts to display the penguin images on the screen.  It 
> renders the anaconda installer dead in the water when you attempt 
> even a text mode install (not graphics) of a 2.2.18-25 kernel (and 24)
> on a DELL laptop.  Is there a way to turn on frame buffer without 
> kicking the kernel into mode 274 and killing DELL laptops during
> a text based install?

Jeff the change that broke or first broke is in 2.2.17-15 if thats any help.

Bob

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
