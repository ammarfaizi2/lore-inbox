Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUL2V0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUL2V0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUL2V0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:26:17 -0500
Received: from hermes.domdv.de ([193.102.202.1]:18956 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261420AbUL2V0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:26:14 -0500
Message-ID: <41D320F3.2010508@domdv.de>
Date: Wed, 29 Dec 2004 22:26:11 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
CC: Paulo Marques <pmarques@grupopie.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org, Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com> <20041229191525.GA2597@node1.opengeometry.net> <41D306AF.1020500@grupopie.com> <20041229205940.GB3024@node1.opengeometry.net>
In-Reply-To: <20041229205940.GB3024@node1.opengeometry.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> I finally wrote a script to build 200MB root filesystem from Slackware
> distribution (A, AP, N, X series).  And, now, you're telling me to build
> a 200kB root filesystem?  I need beer...

You don't need beer, you need busybox. The smallest initrd I made with 
busybox is 99kB (finds boot cdrom and sets up a ram disk as rootfs).

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
