Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMAy4>; Sun, 12 Nov 2000 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKMAyr>; Sun, 12 Nov 2000 19:54:47 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5135 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129040AbQKMAyb>; Sun, 12 Nov 2000 19:54:31 -0500
Date: Sun, 12 Nov 2000 18:54:13 -0600
To: "Carlos E. Gorges" <carlos@techlinux.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Unresolved Symbols in wavefront module ( k 2.2.17 )
Message-ID: <20001112185413.B18203@wire.cadcamlab.org>
In-Reply-To: <00111222283100.01504@shark.techlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111222283100.01504@shark.techlinux>; from carlos@techlinux.com.br on Sun, Nov 12, 2000 at 10:17:40PM -0200
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Carlos E. Gorges]
> This fixes the unresolved symbol detect_wf_mpu to module
> wavefront .
> 
> Patch attached.

1) Do not use gzipped attachments -- in fact do not use attachments at
all, unless the file you wish to attach is already in binary form, or
is extremely long.  Inline text is less trouble to read, and just as
easy to apply ('patch' has no problem skipping non-patch material).

2) 'diff -urN {old} {new}' not 'diff -urN {new} {old}'.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
