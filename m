Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUI1Iq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUI1Iq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 04:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUI1Iq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 04:46:58 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:50317 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267632AbUI1Iq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 04:46:57 -0400
Message-ID: <dc54396f04092801465d278b73@mail.gmail.com>
Date: Tue, 28 Sep 2004 10:46:56 +0200
From: Ed Schouten <edschouten@gmail.com>
Reply-To: Ed Schouten <edschouten@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] i386: Xbox support
Cc: nickpiggin@yahoo.com.au
In-Reply-To: <415915F0.2000803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210>
	 <4158AA5B.8090601@yahoo.com.au>
	 <dc54396f040927214651393131@mail.gmail.com>
	 <415915F0.2000803@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 17:42:40 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Well, I ask because there is probably quite a large number of embedded type
> devices devices that you could "just add a small patch for" to get it working.
> 
> The added fact that you have to "hack" the hardware (I think?) to even get
> it to run Linux makes it probably a bit more questionable (it is great that
> we can run on xbox, but maybe not too harmful to keep it as an external patch).

Yes, you have multiple options to get Linux on it (flash the BIOS with
cromwell, grub-based bootloader, alter some of its current software,
etc).

The reason why the Xbox-Linux folks and I think it should belong in
the main tree is adoption. Xbox Linux has been around since 2001 if I
remember correctly and there are almost no distributions around that
really support the Xbox. The people at Debian for example will only
add Xbox support if it is available in the main tree.

Yours,
-- 
 Ed Schouten <edschouten@gmail.com>
 Website: http://g-rave.nl/
