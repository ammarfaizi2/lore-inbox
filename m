Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313422AbSDQTBO>; Wed, 17 Apr 2002 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313472AbSDQTBN>; Wed, 17 Apr 2002 15:01:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21255 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313422AbSDQTBJ>; Wed, 17 Apr 2002 15:01:09 -0400
Date: Wed, 17 Apr 2002 11:59:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
In-Reply-To: <20020417110809.R745@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0204171156030.17829-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Apr 2002, Larry McVoy wrote:
>
> What about "target"?

Well, it sounds unambiguous at least to me, and "makes sense".

Which still leaves the actual code implementation cleanliness issues, of
course (modulo the USB documentation specifying that "target" means a
small USB-controlled fish, thereby confusing all the USB developers).

			Linus

