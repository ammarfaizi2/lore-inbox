Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSAZRgc>; Sat, 26 Jan 2002 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSAZRgW>; Sat, 26 Jan 2002 12:36:22 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:29595 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S285720AbSAZRgT>; Sat, 26 Jan 2002 12:36:19 -0500
Date: Sat, 26 Jan 2002 18:36:37 +0100
From: Roland Arendes <roland@arendes.de>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Roland Arendes <roland@arendes.de>
X-Priority: 3 (Normal)
Message-ID: <73506817655.20020126183637@arendes.de>
To: "Stolle, Martin (KIV)" <MStolle@kiv.de>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.17 with -rmap VM patch ROCKS!!!
In-Reply-To: <4353BABFDF95D311BFC30004AC4CB22AAE3495@sdar000001.kiv-da.de>
In-Reply-To: <4353BABFDF95D311BFC30004AC4CB22AAE3495@sdar000001.kiv-da.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi Stolle, Martin (KIV),

SMK> I installed 2.4.17-rmap-11c and later 2.4.17-rmap-12a on my
SMK> 2-CPU-Pentium-III
SMK> and on one of my 4-CPU-Xeon-III's, and since then, the machine isn't
SMK> swapping any
SMK> longer.
SMK> Thanks to you and Rik van Riels!
SMK> I would like if Rik's kernel patches would go into standard.
SMK> They are really well!

I can really agree to those statements. It also seems that my
harddrives are more quiet and faster, because the heavy swap-accesses
of the official 2.4.17 are gone.

(It's now even possible to compile a 2.4.17 with -j2 on a SMP system with 64MB
without swap-usage! Yes, it's a lower end system :)

Marcelo: I recommend the rmap12a-patch for the official stable tree. Please
have a look at rmap12a!

-roland

