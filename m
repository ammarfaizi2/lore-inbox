Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292266AbSBBLXF>; Sat, 2 Feb 2002 06:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292267AbSBBLW4>; Sat, 2 Feb 2002 06:22:56 -0500
Received: from fw.aub.dk ([195.24.1.194]:5504 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S292266AbSBBLWn>;
	Sat, 2 Feb 2002 06:22:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Issues with 2.5.3-dj1
Date: Sat, 2 Feb 2002 12:19:02 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com>
In-Reply-To: <20020202055115.GA11359@kroah.com>
X-BeenThere: crackmonkey@crackmonkey.org
X-Fnord: +++ath
X-Message-Flag: Message text blocked
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16WyCH-0000E1-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 February 2002 06:51, Greg KH wrote:
> On Fri, Feb 01, 2002 at 10:36:32PM -0500, Nathan wrote:
> > System is a Sony VAIO R505JE, kernel 2.5.3-dj1 + preempt + acpi + acpi
> > pci irq routing.  Debian unstable, updated today.
> >
> > 1: USB dies a very similar death in 2.5.3-dj1 as it did in 2.5.2-dj6
> > (OOPS below and in previous mail).  What else can I provide?
>
> What were you doing with USB at the time?  Unloading the drivers?  What
> USB host controller, and USB drivers were you using?
>
> And the most important of all, does this also happen in 2.5.3?
>
I see the same with 2.5.2-dj6.. It happens on shutdown.

-Allan
