Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262376AbREUDjT>; Sun, 20 May 2001 23:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbREUDjJ>; Sun, 20 May 2001 23:39:09 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:35310
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262376AbREUDix>; Sun, 20 May 2001 23:38:53 -0400
Date: Sun, 20 May 2001 23:38:51 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: "Robert M. Love" <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: Background to the argument about CML2 design philosophy
In-Reply-To: <990393002.1322.4.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0105202335290.18874-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 May 2001, Robert M. Love wrote:

> I feel that there should *never ever* be a legit situation that the
> configuration tool does not allow. Not ever. Two reasons:
>
> First, I tend to trust the config tools (perhaps too much).  If they
> tell me x implies y, or x implies not y, I will believe it.  I won't
> think "hm, the code must be wrong, let me hand edit the config" (which
> is something I don't want to have to do, anyhow).

Then just don't go as far as using it in "Expert (might be unsafe)" mode.
If you blindly trust the tool that much the intermediate mode might be what
you need.


Nicolas

