Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285435AbRLGJAr>; Fri, 7 Dec 2001 04:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285438AbRLGJAh>; Fri, 7 Dec 2001 04:00:37 -0500
Received: from pixar.pixar.com ([138.72.10.20]:2799 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S285435AbRLGJA3>;
	Fri, 7 Dec 2001 04:00:29 -0500
Date: Fri, 7 Dec 2001 01:00:19 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: Dan Maas <dmaas@dcine.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <098201c17ef0$44758d90$1a01a8c0@allyourbase>
Message-ID: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Dan Maas wrote:
> > We suddenly started seeing freezing problems on a number of machines
> > in the past couple of days. There is no pattern as far as I can tell.
> > It has happened while running OpenGL apps, netscape, or even when not
> > doing anything.
> 
> > Software:
> >     - NVIDIA drivers 1.0-1541
> 
> Sorry, we do not have the source to NVIDIA's driver, so we cannot help you
> debug this problem. Please contact NVIDIA support.

I don't see how one can magically tell that this is an NVIDIA problem. 
I am contacting NVIDIA at the same time and it's possible that the 
problem is with their drivers. However, there is something going on 
in the kernel and I imagine that even if the NVIDIA drivers are 
triggering the problem, there are other modules/apps that can bring 
about the same behavior.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

