Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRJHFNC>; Mon, 8 Oct 2001 01:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRJHFMw>; Mon, 8 Oct 2001 01:12:52 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:60169 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S276361AbRJHFMo>; Mon, 8 Oct 2001 01:12:44 -0400
Subject: Re: [BUG] emu10k1 and SMP
From: Robert Love <rml@tech9.net>
To: Kenneth Johansson <ken@canit.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC0D5F9.3C6DCF93@canit.se>
In-Reply-To: <3BC0D5F9.3C6DCF93@canit.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 08 Oct 2001 01:13:33 -0400
Message-Id: <1002518015.999.93.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-07 at 18:23, Kenneth Johansson wrote:
> I have a problem with my sblive card with some program when I compile
> 2.4.10 and -ac8 for SMP.
> 
> This happens with programs from loki and the machine stops or power down
> (yes an actuall power down). I'am sure this is sound related as stuff
> works if I don't load the emu10k1 driver and it only happens with SMP.

Can you give a better description of the problem?

Are you using the sblive driver from the kernel or CVS or ALSA?

Does the problem go away if you recompile with CONFIG_SMP=n ?

What exactly happens? Oops?  Can you debug?  Reproduce?  Anything?

	Robert Love

