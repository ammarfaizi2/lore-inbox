Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTJDIC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJDIC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 04:02:59 -0400
Received: from gprs147-84.eurotel.cz ([160.218.147.84]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261939AbTJDICy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 04:02:54 -0400
Date: Sat, 4 Oct 2003 10:02:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
Message-ID: <20031004080239.GA213@elf.ucw.cz>
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise> <20031003223352.GB344@elf.ucw.cz> <3F7E57E9.8070904@ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7E57E9.8070904@ccs.neu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >+ *    Note: The buffer we allocate to use to write the suspend header is
> >+ *    not freed; its not needed since system is going down anyway
> >+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
> >+ */
> 
> Too lazy to properly fix your comment as well.

Can you elaborate?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
