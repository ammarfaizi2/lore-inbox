Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263448AbSIQB2R>; Mon, 16 Sep 2002 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263450AbSIQB2R>; Mon, 16 Sep 2002 21:28:17 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:10211 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S263448AbSIQB2Q>;
	Mon, 16 Sep 2002 21:28:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
References: <20020916042625.55842.qmail@web40509.mail.yahoo.com>
	<20020915.220131.104193664.davem@redhat.com>
	<1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
	<20020916.121423.109699832.davem@redhat.com>
In-Reply-To: <20020916.121423.109699832.davem@redhat.com> ("David S.
 Miller"'s message of "Mon, 16 Sep 2002 12:14:23 -0700 (PDT)")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Tue, 17 Sep 2002 11:33:11 +1000
Message-ID: <8765x5z9go.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 16 Sep 2002 13:42:11 +0100
> 
>    What is sad is the is an AGP standardised way to read this and
>    XFree86 still, all these years on, doesn't do it by default.
> 
> Totally agreed.
> 
> I have even suggested on the xfree86 developer list at least 2 times
> that they do this to choose the default, but they claim it isn't the
> right thing to do.
> 
> So people's boxes will keep hanging and xfree86 DRM will continue to
> be a support nightmare.

...which might explain why my machine has occasional DRM related hangs,
since there is no way for me to match the XFree86 AGP speed and the BIOS
set AGP speed -- my BIOS will not tell me what it set, nor does it have
a toggle to adjust it.

Does some tool already exist that can query this information from
userspace? If not, are the specifications needed to build one freely
available?

        Daniel

-- 
Now that mountains of meaningless words and oceans divide us
And we each have our own set of stars to comfort and guide us
        -- Nick Cave, _Come Into My Sleep_
