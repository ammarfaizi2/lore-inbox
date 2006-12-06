Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936325AbWLFQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936325AbWLFQVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936331AbWLFQVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:21:36 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:60703 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S936325AbWLFQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:21:35 -0500
Date: Wed, 6 Dec 2006 17:21:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: =?UTF-8?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
In-Reply-To: <1165332650.2756.27.camel@localhost>
Message-ID: <Pine.LNX.4.62.0612061720390.28483@pademelon.sonytel.be>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
 <1165308400.2756.2.camel@localhost>  <45758CB3.80701@redhat.com>
 <1165332650.2756.27.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Marcel Holtmann wrote:
> the only problem are public and exported interfaces and function. For
> static code you can use whatever you want. I personally would go with
> "ieee1394", because that is the official name for it. Otherwise go with
> "firewire" if you wanna separate yourself from the previous stack.

Which still leaves the opportunity for having a third stack in drivers/ilink
:-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
