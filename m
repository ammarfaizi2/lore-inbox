Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbUCVV7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUCVV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:59:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62157 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263710AbUCVV7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:59:34 -0500
Date: Mon, 22 Mar 2004 22:59:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jos Hulzink <jos@hulzink.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322215921.GU16746@fs.tum.de>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322202220.GA13042@mulix.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 10:22:21PM +0200, Muli Ben-Yehuda wrote:
>...
> I've seen
> multiple bug reports of cards that work with OSS and don't work with
> ALSA (and vice versa), so keeping both seems the proper thing to
>...

Wouldn't it be better to get the ALSA drivers working in such cases?

It's really not a good idea to have two codebases for the same purpose.

> Cheers, 
> Muli 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

