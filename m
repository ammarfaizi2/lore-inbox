Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272127AbTHDSdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTHDSc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:32:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:13959 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S272127AbTHDSct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:32:49 -0400
Date: Mon, 4 Aug 2003 11:31:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-Id: <20030804113144.47fcc112.davem@redhat.com>
In-Reply-To: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 10:37:39 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> As of this morning, Linus's current bk tree
> (http://linux.bkbits.net:8080/linux-2.5) builds and works out of the
> box for ia64!

I hate to rain on your parade, but for a platform that has so many
companies paying people full time to maintain under Linux having it
take this long is a big diasppointment for me :(

I do sparc64 as a hobby in my spare time, as a single individual, and
it has been working daily throughout the entire 2.4.x and 2.5.x
series.

The fact that there are still "external patches for performance"
is even more disheartening.

My tree never lags Linus's by more than 24 or 48 hours, unless one
of us is on vacation and not near computers.  And if I can do this
in my spare time, it should be doable by people getting paid full
time to maintain the ia64 port, don't you think? 8-)
