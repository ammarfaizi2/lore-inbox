Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUBJN7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUBJN7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:59:51 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:62347 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S265878AbUBJN7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:59:50 -0500
Date: Tue, 10 Feb 2004 06:00:18 -0800
From: Mike Bell <kernel@mikebell.org>
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210140018.GG4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <Pine.LNX.4.58.0402102104050.5127@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402102104050.5127@raven.themaw.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:32:57PM +0800, Ian Kent wrote:
> So if devfs is needed by people then we must get together and do what is 
> needed to support and develop the product.
> 
> Lets not forget that, at this point, udev is a recommended replacement for 
> devfs, but is (I believe) still in development. So it may well happen 
> that udev is an appropriate replacement for devfs at some point and that 
> must be considered fairly and sensibly when the time comes.

I agree that if udev is going to be maintained while devfs is left to
rot, udev is the way to go. My post was because the impression I got
from the udev author's posts was that devfs was dead and udev was the
designated successor, and superior in every way. Only when I really
looked at the arguments did I start to question.

So really, I was trying to ensure I was correct about devfs
(or the concept, at least) still offerring some things that the udev
concept never will, and to see if there were other people who would
still like to see devfs (or a devfs-alike, reimplemented without its
various problems) live on. It's pretty hard to form a user community for
devfs when it has been declared dead and its successor named, but that's
very much the impression I get from the udev author's posts (or at least
those reproduced in places like kernel-traffic).

So yeah, not an attempt to start a flamewar, I just wanted to register
myself as someone who doesn't see udev as the ideal solution, and see if
there were any others.
