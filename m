Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbUKYBAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUKYBAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUKYBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:00:48 -0500
Received: from uucp.gnuu.de ([151.189.20.84]:8977 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id S262888AbUKYA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:59:45 -0500
From: Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: Audio problems on AMD64 with Via K8T800 chipset
To: linux-kernel@vger.kernel.org
References: <E1CWyoi-00070L-00@mastermind.netrics.internal>
User-Agent: tin/1.7.7-20041006 ("Baleshare") (UNIX) (Linux/2.4.27-182 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <E1CX6xq-0002g9-3B@ds9.argh.org>
Date: Thu, 25 Nov 2004 00:54:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sharkey <sharkey@netrics.com> wrote:

> There seems to be a problem with Alsa when running on the AMD64
> architecture on motherboards with the Via K8T800 chipset.  The sound
> is highly irregular, with lots of drop-outs, but also speed-ups,
> slow-downs and weird volume changes.

While using the in-kernel Alsa, my ens1371 based Soundblaster behaved
the same way, but with the seperate Alsa modules (1.0.6a from Debian
unstable) the blopping, crackling etc. is far less present, but still
audible in some cases, mostly disk I/O.

(Kernel 2.6.9 with staircase 9.1, Abit KV8 Pro, AMD64 3200+)

Grüße,
S°
