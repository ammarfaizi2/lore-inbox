Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132058AbQLQC6B>; Sat, 16 Dec 2000 21:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbQLQC5u>; Sat, 16 Dec 2000 21:57:50 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:31758 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132086AbQLQC5n>; Sat, 16 Dec 2000 21:57:43 -0500
Date: Sat, 16 Dec 2000 20:27:13 -0600
To: David Relson <relson@osagesoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test13p1 - NFS module problem
Message-ID: <20001216202713.Q3199@cadcamlab.org>
In-Reply-To: <4.3.2.7.2.20001215162135.00b47ed0@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20001215162135.00b47ed0@mail.osagesoftware.com>; from relson@osagesoftware.com on Fri, Dec 15, 2000 at 04:42:32PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[David Relson]
> I just built test13-pre1 and have some unresolved nfs symbols.

Keith Owens posted a patch for this.  I think it was just removing the
EXPORT_NO_SYMBOLS line from fs/lockd/svc.c.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
