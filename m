Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbSJBU0K>; Wed, 2 Oct 2002 16:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSJBU0K>; Wed, 2 Oct 2002 16:26:10 -0400
Received: from mail.eastlink.de ([213.187.64.4]:15367 "EHLO mail.eastlink.de")
	by vger.kernel.org with ESMTP id <S262567AbSJBU0K>;
	Wed, 2 Oct 2002 16:26:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ralf Gerbig <rge-news@dialeasy.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.5 input drivers Synaptics touchpad
Date: Wed, 2 Oct 2002 22:22:56 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200210021824.54927@hsp-law.de> <20021002204428.A20378@ucw.cz>
In-Reply-To: <20021002204428.A20378@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210022222.57408@hsp-law.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

Am Mittwoch, 2. Oktober 2002 20:44 schrieb Vojtech Pavlik:
> On Wed, Oct 02, 2002 at 06:24:54PM +0200, Ralf Gerbig wrote:
> > Hi Vojtech,
> >
> > I just tried 2.5.40 and could not get the Synaptics touchpad on an Acer
> > Travelmate 353 to work with either the synaptics driver for XFree
> > at http://www.mobilix.org/software/synaptics/ or tpconfig at
> > http://www.compass.com/synaptics/ gpm also does not like the synps2
> > protocol. Works as (im)ps/2 though.

> Yes, for 2.5 I still have to write a synaptics touchpad kernel driver
> for it to work properly.

is there any kind of 'raw' psaux interface to those userspace drivers?
looks to me as a, at least stopgap, solution. With the disclamer that
I know nothing about the interface or the kernel, but i've read the
mantra 'userspace' many times (for values of userspace as in X and gpm).

Thanks,

Ralf

