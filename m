Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbQLNBA1>; Wed, 13 Dec 2000 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbQLNBAR>; Wed, 13 Dec 2000 20:00:17 -0500
Received: from mdj.nada.kth.se ([130.237.224.206]:61702 "EHLO mdj.nada.kth.se")
	by vger.kernel.org with ESMTP id <S129763AbQLNBAO>;
	Wed, 13 Dec 2000 20:00:14 -0500
To: "Mohammad A. Haque" <mhaque@haque.net>
Subject: Re: test12 lockups -- need feedback
In-Reply-To: <3A3804CA.E07FDBB1@haque.net> <xy7hf47n95t.fsf@mdj.nada.kth.se>
Reply-To: djurfeldt@nada.kth.se
Cc: linux-kernel@vger.kernel.org, djurfeldt@nada.kth.se
From: Mikael Djurfeldt <mdj@mdj.nada.kth.se>
Date: 14 Dec 2000 01:29:46 +0100
In-Reply-To: Mikael Djurfeldt's message of "14 Dec 2000 01:22:54 +0100"
Message-ID: <xy7d7evn8ud.fsf@mdj.nada.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Djurfeldt <mdj@mdj.nada.kth.se> writes:

> "Mohammad A. Haque" <mhaque@haque.net> writes:
> 
> > Those of you who are having lockups, was test12 compiled from a patched
> > tree that you've previously compiled?
> 
> I downloaded the full test12 and have lockups after using X (upstream
> version 4.0.1Z) 15-45 mins.  For me, SysRq+u works, but if I then
> press SysRq+b, nothing happens.  There are no signs in the syslog.

I should add that I didn't have these lockups in test12-pre8.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
