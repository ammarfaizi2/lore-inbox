Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRERRfs>; Fri, 18 May 2001 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261280AbRERRfi>; Fri, 18 May 2001 13:35:38 -0400
Received: from www.wen-online.de ([212.223.88.39]:26638 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261274AbRERRfe>;
	Fri, 18 May 2001 13:35:34 -0400
Date: Fri, 18 May 2001 19:35:07 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: <esr@thyrsus.com>, Arjan van de Ven <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <l03130303b72af49d4f0a@[192.168.239.105]>
Message-ID: <Pine.LNX.4.33.0105181919190.480-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Jonathan Morton wrote:

> As for the language CML2 is written in, surely C would work just as well as
> Python if the config-ruleset file is in a known format.  GCC is required
> for the kernel to build, I don't see why anything else should be required
> simply to configure it.

Menuconfig is fairly popular, and requires curses.. etc. etc.  There isn't
a configurator which doesn't require something more than gcc is there?

OTOH, python here says: Python 1.3 (Dec 19 1995)  [GCC 2.7.2]. I didn't
have it built at all during the years prior to 1995, so I'm sure you can
imagine how enthusiastic I am about upgrading that old turd ;-)

	-Mike

