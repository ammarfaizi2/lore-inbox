Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQLRRiZ>; Mon, 18 Dec 2000 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLRRiP>; Mon, 18 Dec 2000 12:38:15 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:34063 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129757AbQLRRiH>;
	Mon, 18 Dec 2000 12:38:07 -0500
Date: Mon, 18 Dec 2000 09:07:45 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <91fhke$6gk$1@enterprise.cistron.net>
Message-ID: <Pine.LNX.4.21.0012180905210.6756-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're confusing /dev/console and /dev/tty0. /dev/console might be
> associated with /dev/ttyS0 or /dev/lp1

Oops. Forgot about serial consoles :-( 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
