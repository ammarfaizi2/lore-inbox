Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261165AbRELEAE>; Sat, 12 May 2001 00:00:04 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261162AbRELD7v>; Fri, 11 May 2001 23:59:51 -0400
Received: from melchi.fuller.edu ([206.2.38.3]:13584 "EHLO melchi.fuller.edu")
	by vger.kernel.org with ESMTP id <S261174AbRELD66>;
	Fri, 11 May 2001 23:58:58 -0400
Date: Fri, 11 May 2001 20:58:55 -0700 (PDT)
From: <clameter@lameter.com>
To: Drew Bertola <drew@drewb.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance
 sucks.
In-Reply-To: <20010510200750.A29230@drewb.com>
Message-ID: <Pine.LNX.4.10.10105112058050.31665-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001, Drew Bertola wrote:

> > The Richochet USB stuff uses generic serial I/O. No special driver. And it
> > works fine under Win/ME. Have you run a regular PPP connection over the
> > ACM driver with an MTU of 1500?
> 
> Joey Hess had a problem similar to what you described, though he noticed
> it while using the pcmcia ricochet modem.  He passed along this patch:

I tried the patch a couple of days ago and it did not do anything for me.


