Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290597AbSA3VIS>; Wed, 30 Jan 2002 16:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290601AbSA3VIL>; Wed, 30 Jan 2002 16:08:11 -0500
Received: from ns.ithnet.com ([217.64.64.10]:48132 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290597AbSA3VIF>;
	Wed, 30 Jan 2002 16:08:05 -0500
Date: Wed, 30 Jan 2002 22:06:59 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Message-Id: <20020130220659.29bd66f5.skraw@ithnet.com>
In-Reply-To: <001701c1a9c4$673dc4b0$020da8c0@nitemare>
In-Reply-To: <Pine.LNX.4.33.0201220746440.13692-100000@jbourne2.mtroyal.ab.ca>
	<001701c1a9c4$673dc4b0$020da8c0@nitemare>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 20:29:15 +0100
"Robbert Kouprie" <robbert@jvb.tudelft.nl> wrote:

> Not much new, but still:
> 
> Today I got the same problem again with 2.4.18-pre3-ac2. Network
> connections stuck, NFS mounts stuck. Bringing down/up the interface
> doesn't help. Seems like the NIC is really in trouble here. Only a
> reboot would bring the nick back in use.
> 
> Still no testcase though, and I have no idea on how to investigate this
> :(
> Can anyone give a hint as where to seek?

How about www.kernel.org? Download _latest_ kernel-patch (-pre7) and tell us
about it. As long as you are trying only old pre's there is not much of
a chance any important brain will listen to you.

Regards,
Stephan
(no important brain)
