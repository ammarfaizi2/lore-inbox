Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273792AbRIXEoS>; Mon, 24 Sep 2001 00:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273793AbRIXEoI>; Mon, 24 Sep 2001 00:44:08 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:149 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S273792AbRIXEny>;
	Mon, 24 Sep 2001 00:43:54 -0400
Message-ID: <3BAEBAB9.2EDD324A@sun.com>
Date: Sun, 23 Sep 2001 21:46:49 -0700
From: Stephane Brossier <stephane.brossier@sun.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [1.] X session randomly crashes because of kernelproblem.
In-Reply-To: <Pine.LNX.4.33.0109220259410.25731-100000@zod.capslock.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

"Mike A. Harris" wrote:
> 
> On Sun, 16 Sep 2001, Stephane Brossier wrote:
> 
> >Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
> >Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
> >Sep 16 19:13:59 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
> >r128_do_wait_for_fifo failed!
> 
> There is a patch which fixes problems such as this.  IIRC, it was
> included in the upstream Linus kernel somewhere in April or
> later.  If you're using XFree86 4.0.3, you'll probably want to
> upgrade to a later kernel, or patch it with the r128 patch.  You
> can get this patch from:
> 
> ftp://people.redhat.com/mharris/patches/linux-r128-drm.patch.bz2
> 

OK. Will try.

Thanks.

Steph.
