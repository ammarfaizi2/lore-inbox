Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJPRst>; Wed, 16 Oct 2002 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJPRst>; Wed, 16 Oct 2002 13:48:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261282AbSJPRss>; Wed, 16 Oct 2002 13:48:48 -0400
Date: Wed, 16 Oct 2002 13:54:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Samuel Flory <sflory@rackable.com>
cc: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <3DADA831.7010601@rackable.com>
Message-ID: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Samuel Flory wrote:

> >
> >
> >On Wed, 16 Oct 2002, Mark Cuss wrote:
> >
> >  
> >
> >
> >This is the correct behavior. If you don't like this, you can
> >swap motherboards with me ;) Otherwise, grin and bear it!
> >
> >  
> >
>  
>   Wouldn't it be easier just to turn off the hypertreading or jackson 
> tech option in the bios ;-)
> 

Why would you ever want to turn it off?  You paid for a CPU with
two execution units and you want to disable one?  This makes
no sense unless you are using Windows/2000/Professional, which
will trash your disks and all their files if you have two
or more CPUs (true).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

