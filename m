Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129917AbRBAK2l>; Thu, 1 Feb 2001 05:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130233AbRBAK2c>; Thu, 1 Feb 2001 05:28:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:39437 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129917AbRBAK2V>; Thu, 1 Feb 2001 05:28:21 -0500
Date: Thu, 1 Feb 2001 04:28:13 -0600
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: spelling of disc (disk) in /devfs
Message-ID: <20010201042813.C27725@cadcamlab.org>
In-Reply-To: <6lah7t4f685qo3igk679ocdo2obfhd9lvg@4ax.com> <20010201034217.A550@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010201034217.A550@foozle.turbogeek.org>; from jmd@foozle.turbogeek.org on Thu, Feb 01, 2001 at 03:42:17AM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeremy M. Dolan]
> Disk is spelled 'disk' except for Compact Disc and Digital Versatile
> Disc. If it wasn't 3:30 in the morning, a patch would be attached.

It wouldn't do any good.  Many months ago, Ted Ts'o pleaded with
Richard Gooch (devfs author, from Australia) to switch to the American
spelling of the word, for consistency with the rest of the kernel, and
nothing came of it.  At this point you may as well consider
'/dev/discs' an "interface set in stone".  (Come on, do *you* want to
explain to thousands of people why their /etc/fstab suddenly broke?)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
