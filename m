Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTIFT4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIFT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:56:08 -0400
Received: from chello080110084234.506.15.vie.surfer.at ([80.110.84.234]:54955
	"EHLO elch.elche") by vger.kernel.org with ESMTP id S261783AbTIFT4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:56:04 -0400
Date: Sat, 6 Sep 2003 21:55:59 +0200
From: Armin Obersteiner <armin@xos.net>
To: Jose Luis Alarcon Sanchez <jlalarcon@chevy.zzn.com>
Cc: armin@xos.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 latencey problems + howto compilation
Message-ID: <20030906195559.GA18299@elch.elche>
References: <A340D5F1860783E4BBC9E429C5A7DAFD@jlalarcon.chevy.zzn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A340D5F1860783E4BBC9E429C5A7DAFD@jlalarcon.chevy.zzn.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

>   I don't know why the previous module-init-tools don't work
> for your system. I am using the 2.6.0-test4 kernel (with the
> Nick Piggin ideas about schedule patched) and i can manage
> modules perfectly. This is my depmod -V output:
> 
> module-init-tools 0.9.10
> 
>   Maybe you can have another thing broken?.

I did not try every version from 0.9.10 to 0.9.13. I can remember
0.9.9 (recommended) did not work and 0.9.14-pre did not work/compile
(most current) so I tried 0.9.13 - and this one worked :)

Of course maybe there is an other cause 0.9.9 not working (I had to
upgrade the normal modutils too), but I would simply recommend 0.9.13 
for 2.6-test5.

Regards,
	Armin
--
armin@xos.net                        pgp public key on request        CU
