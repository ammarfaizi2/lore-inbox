Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129173AbRBGHAz>; Wed, 7 Feb 2001 02:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBGHAq>; Wed, 7 Feb 2001 02:00:46 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:29711 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129173AbRBGHAg>; Wed, 7 Feb 2001 02:00:36 -0500
Date: Wed, 7 Feb 2001 04:00:00 -0300
From: John R Lenton <john@grulic.org.ar>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
Message-ID: <20010207035959.A2223@grulic.org.ar>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3A7E1942.5090903@goingware.com> <20010205180646.B32155@cadcamlab.org> <033601c09075$a60e43e0$de00a8c0@homeip.net> <20010206154616.A9875@animx.eu.org> <20010207002510.A10556@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010207002510.A10556@cadcamlab.org>; from peter@cadcamlab.org on Wed, Feb 07, 2001 at 12:25:10AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 12:25:10AM -0600, Peter Samuelson wrote:
> 
> [Wakko Warner]
> > I have a question, why was this idea even considered?
> 
> Al Viro likes Plan9 process-local namespaces.  He seems to be trying to
> move Linux in that direction.  In the past year he has been hacking the
> semantics of filesystems and mounting, probably with namespaces as an
> eventual goal, and this is one of the things that has fallen out of the
> implementation.

Aren't "translucid" mounts the idea behind this?
-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
For courage mounteth with occasion.
		-- William Shakespeare, "King John"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
