Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271581AbRIBG1L>; Sun, 2 Sep 2001 02:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRIBG1B>; Sun, 2 Sep 2001 02:27:01 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:1797 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S271581AbRIBG0y>;
	Sun, 2 Sep 2001 02:26:54 -0400
Date: Sun, 2 Sep 2001 02:29:01 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <Pine.LNX.4.33.0109011824280.1096-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109020228001.1712-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ACPI doesnt give a different result.. using 2.4.9-ac5 with pnpbios enabled
doesnt change anything either...

Tester

On Sat, 1 Sep 2001, Linus Torvalds wrote:

>
> On Sat, 1 Sep 2001, Tester wrote:
> >
> > I dont have ACPI enabled, but I have APM support...
> > Should I try enabling ACPI?
>
> It would be interesting to hear what happens. I bet you won't be happy
> with it compared to APM due to the lack of proper suspend etc, but from a
> testing standpoint it would be good to hear what happens, and what
> /proc/interrupts and ACPI report about the thing..
>
> 		Linus
>
>

-- 
Tester
tester@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer

