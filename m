Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDWUiX>; Mon, 23 Apr 2001 16:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDWUhk>; Mon, 23 Apr 2001 16:37:40 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:38564 "EHLO
	nynetops04.e-steel.com") by vger.kernel.org with ESMTP
	id <S131724AbRDWUhe>; Mon, 23 Apr 2001 16:37:34 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: ioctl arg passing
Date: 23 Apr 2001 16:37:28 -0400
Organization: e-STEEL Netops news server
Message-ID: <m3wv8bl5dj.fsf@shookay.e-steel.com>
In-Reply-To: <20010423195043.S682@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.33.0104232155230.1417-100000@localhost.localdomain>
NNTP-Posting-Host: shookay.e-steel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: nynetops04.e-steel.com 988054558 18412 192.168.3.43 (23 Apr 2001 19:35:58 GMT)
X-Complaints-To: news@nynetops04.e-steel.com
NNTP-Posting-Date: 23 Apr 2001 19:35:58 GMT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<rui.sousa@mindspeed.com> writes:

> On Mon, 23 Apr 2001, Ingo Oeser wrote:
> 
> > On Mon, Apr 23, 2001 at 05:06:48PM +0100, Matt wrote:
> > > I'm writing a char device driver for a dsp card that drives a motion
> > > platform.
> >
> > Can you elaborate on the dsp card? Is it freely programmable? I'm
> > working on a project to support this kind of stuff via a
> > dedicated subsystem for Linux.
> 
> Very interesting... The emu10k1 driver (SBLive!) that will appear
> shortly in acXX will support loading code to it's DSP. It's a very
> simple chip with only 16 instructions but it can generate
> hardware interrupts, DMA to host memory, 32 bit math. The maximum
> program size is 512 instructions (64 bits each) and can make use of 256
> registers (32 bits).

Do you mean we will be able to have the same kind of stuff they have on
Windows (like the mp3 encoding computed by the SB Live)??

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
