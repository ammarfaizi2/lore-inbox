Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSC1JeZ>; Thu, 28 Mar 2002 04:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313121AbSC1JeQ>; Thu, 28 Mar 2002 04:34:16 -0500
Received: from insgate.stack.nl ([131.155.140.2]:49674 "HELO skynet.stack.nl")
	by vger.kernel.org with SMTP id <S313118AbSC1JeA>;
	Thu, 28 Mar 2002 04:34:00 -0500
Date: Thu, 28 Mar 2002 10:33:57 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Erik Andersen <andersen@codepoet.org>,
        jw schultz <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020327193126.J29474@redhat.com>
Message-ID: <20020328103117.G5099-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Benjamin LaHaise wrote:

> What about the hot swap bays I've picked up that properly handle power
> up/down?  If that is the only device on the bus and the interface is
> properly tristated, what prevents hot swap?
>
The fact it MIGHT work. I don't want to have to do anything with an OS
that tells me:

It might now be safe to unplug your IDE device and if you are lucky your
mainboard and drive are still alive.

When you need hotplug capability buy decent hardware.

Jos

