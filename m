Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbRE1QJh>; Mon, 28 May 2001 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbRE1QJR>; Mon, 28 May 2001 12:09:17 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:61705 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S263084AbRE1QJG>;
	Mon, 28 May 2001 12:09:06 -0400
Date: Mon, 28 May 2001 12:09:05 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
Message-ID: <20010528120905.A32157@saturn.tlug.org>
Mail-Followup-To: Mike Frisch <mfrisch@saturn.tlug.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010528175712.B18955@pua.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528175712.B18955@pua.nirvana>; from Axel.Thimm@physik.fu-berlin.de on Mon, May 28, 2001 at 05:57:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 05:57:12PM +0200, Axel Thimm wrote:
> What is the status of the support for this chipset, found for example in an
> ASUS A7A266? Judging from
>              http://www.acerlabs.com/eng/support/faqlnx.htm
> one gets the impression that ALi is respectfully treating the Linux community.

I cannot answer your question about the level of support this chipset
has, but suffice it to say that my new (as of last week) A7A266 based
system (1.2Ghz T-Bird w/256MB Crucial DDR RAM) is running 2.4.5 (and
previous to that 2.2.18) quite nicely.  Perhaps Linux is not optimized
for performance with this chipset, but it feels fast to me.

According to 'hdparm -t /dev/hda', I am getting 25MB/s transfer rates
with my Quantum Fireball Plus LM.  Seems a little high, but drive
performance 'feels' good.

Based on my weekend experience with this board and Linux, I think I have
made the right choice.
