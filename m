Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130134AbQKCAQw>; Thu, 2 Nov 2000 19:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130158AbQKCAQm>; Thu, 2 Nov 2000 19:16:42 -0500
Received: from quattro.sventech.com ([205.252.248.110]:18697 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130134AbQKCAQb>; Thu, 2 Nov 2000 19:16:31 -0500
Date: Thu, 2 Nov 2000 19:16:27 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Greg KH <greg@wirex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre19
Message-ID: <20001102191625.T25191@sventech.com>
In-Reply-To: <20001102132206.B2424@wirex.com> <Pine.LNX.4.10.10011030203590.31286-300000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.10.10011030203590.31286-300000@iq.rulez.org>; from Sasi Peter on Fri, Nov 03, 2000 at 02:08:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000, Sasi Peter <sape@iq.rulez.org> wrote:
> On Thu, 2 Nov 2000, Greg KH wrote:
> 
> > Could you send the result of /proc/interrupts and 'lspci -v'?
> > Also, have you tried the alternate UHCI controller driver?
> > Or tried USB as modules, instead of compiled in?
> 
> Here you go. I did work w/ the very same hw with pre15.
> 
> I have never really knew what the UHCI JE was all about... So it can be
> used in place of the original UHCI? I will make a try. (and why JE?)

Yes, it's a drop in replacement. Choose one or the other.

"JE" because it's my initials.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
