Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbRAACSo>; Sun, 31 Dec 2000 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRAACS1>; Sun, 31 Dec 2000 21:18:27 -0500
Received: from mail.sonicity.com ([63.251.235.60]:41992 "HELO
	mail.sonicity.com") by vger.kernel.org with SMTP id <S130468AbRAACSU>;
	Sun, 31 Dec 2000 21:18:20 -0500
Date: Sun, 31 Dec 2000 17:47:53 -0800 (PST)
From: Justin <keyser-lk@soze.net>
To: Tony Hoyle <tmh@magenta-netlogic.com>
Cc: Tony Spinillo <tspin@epix.net>, <linux-kernel@vger.kernel.org>
Subject: Re: TEST13-PRE7 - Nvidia Kernel Module Compile Problem [OFF TOPIC]
In-Reply-To: <3A4FCC54.14F38593@magenta-netlogic.com>
Message-ID: <Pine.LNX.4.30.0012311739500.1653-100000@straylight.int.sonicity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Tony Hoyle wrote:

> I'm intrigued... how did you resolve the 'mem_map_inc_count' and
> 'mem_map_dec_count',
> 'put_module_symbol' and 'get_module_symbol' references?
>
> It's only of academic interest for me now as I've ditched the nvidia -
> not worth the hassle.
>
> Amusingly, We're breaking the EULA even by reading the supplied source
> code...

usually there are patches on irc.openprojects.net #nvidia after a day or
less whenever kernel changes fsck up the latest nvidia kernel module.


justin
-- 
I see dead people.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
