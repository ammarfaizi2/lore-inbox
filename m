Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270874AbUJUTVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270874AbUJUTVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbUJUTVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:21:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:44940 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270874AbUJUTVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:21:02 -0400
Date: Thu, 21 Oct 2004 21:20:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Mildred Frisco <mildred.frisco@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: making a linux kernel with no root filesystem
In-Reply-To: <200410211453.22507.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.61.0410212120280.10671@waterleaf.sonytel.be>
References: <e7b30b2404102102466dc71118@mail.gmail.com>
 <200410211453.22507.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, Denis Vlasenko wrote:
> You want a "prompt where I can either shutdown or reboot the system".
> How to do that? It is best done from small userspace environment,
> like initrd or initramfs. Putting this into kernel is ugly.

Magic Sysrequest?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
