Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSAMDeX>; Sat, 12 Jan 2002 22:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbSAMDeN>; Sat, 12 Jan 2002 22:34:13 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33030 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280975AbSAMDd7>; Sat, 12 Jan 2002 22:33:59 -0500
Message-ID: <3C410018.5438AB89@linux-m68k.org>
Date: Sun, 13 Jan 2002 04:33:44 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PTB7-0002rC-00@the-village.bc.nu> <3C409FB2.8D93354F@linux-m68k.org> <20020112151347.A6981@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> Well, how about a third possibility - that I see a problem you have not
> seen and that you should try to argue on technical terms

I just don't see any problem that is really new. Alan's example is one
of more extreme ones, but the only effect is that an operation can be
delayed far more than usual, but not indefinitely.
If you think preemption can cause a deadlock, maybe you could give me a
hint, which of the conditions for a deadlock is changed by preemption?

> instead of psychoanlyzing
> me or looking for financial motives?

If I had known, how easily people are offended by implying they could
act out of financial interest, I hadn't made that comment. Sorry, but
I'm just annoyed, how you attack any attempt to add realtime
capabilities to the kernel, mostly with the argument that it sucks under
IRIX. I people want to try it, let them. I prefer to see patches and if
they should really suck, I would be first one to say so.

bye, Roman
