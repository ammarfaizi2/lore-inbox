Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbQLNAx5>; Wed, 13 Dec 2000 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbQLNAxs>; Wed, 13 Dec 2000 19:53:48 -0500
Received: from mdj.nada.kth.se ([130.237.224.206]:60166 "EHLO mdj.nada.kth.se")
	by vger.kernel.org with ESMTP id <S129704AbQLNAxa>;
	Wed, 13 Dec 2000 19:53:30 -0500
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12 lockups -- need feedback
In-Reply-To: <3A3804CA.E07FDBB1@haque.net>
Reply-To: djurfeldt@nada.kth.se
Cc: djurfeldt@nada.kth.se
From: Mikael Djurfeldt <mdj@mdj.nada.kth.se>
Date: 14 Dec 2000 01:22:54 +0100
In-Reply-To: "Mohammad A. Haque"'s message of "Wed, 13 Dec 2000 18:22:50 -0500"
Message-ID: <xy7hf47n95t.fsf@mdj.nada.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" <mhaque@haque.net> writes:

> Those of you who are having lockups, was test12 compiled from a patched
> tree that you've previously compiled?

I downloaded the full test12 and have lockups after using X (upstream
version 4.0.1Z) 15-45 mins.  For me, SysRq+u works, but if I then
press SysRq+b, nothing happens.  There are no signs in the syslog.

I'm using the latest Debian packages from the Woody release on an
Mobile Pentium II, 333 MHz, 160 Mb ram.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
