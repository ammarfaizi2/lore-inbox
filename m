Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRIBB2x>; Sat, 1 Sep 2001 21:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIBB2n>; Sat, 1 Sep 2001 21:28:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32521 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269779AbRIBB2b>; Sat, 1 Sep 2001 21:28:31 -0400
Date: Sat, 1 Sep 2001 18:25:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tester <tester@videotron.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <Pine.LNX.4.33.0109011513320.1294-100000@TesterTop.PolyDom>
Message-ID: <Pine.LNX.4.33.0109011824280.1096-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 1 Sep 2001, Tester wrote:
>
> I dont have ACPI enabled, but I have APM support...
> Should I try enabling ACPI?

It would be interesting to hear what happens. I bet you won't be happy
with it compared to APM due to the lack of proper suspend etc, but from a
testing standpoint it would be good to hear what happens, and what
/proc/interrupts and ACPI report about the thing..

		Linus

