Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKTQn5>; Mon, 20 Nov 2000 11:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129248AbQKTQnq>; Mon, 20 Nov 2000 11:43:46 -0500
Received: from wg.redhat.de ([193.103.254.4]:60420 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S129231AbQKTQnn>;
	Mon, 20 Nov 2000 11:43:43 -0500
Date: Mon, 20 Nov 2000 17:13:41 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.4.21.0011201402260.1575-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0011201649060.16038-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Tigran Aivazian wrote:

> Try Red Hat 7.0 -- it is certainly better. True, no distribution is
> perfect but over the years I've developed my own CD image upgrade.iso
> which goes directly after installing latest Red Hat distribution. It is
> full of things like BRS, dict(1), 'alias md="mkdir -p"' or "set
> editing-mode vi" which should be installed by default but for some reason
> aren't.

Is this thing available for download somewhere? I'd definitely like to see
what we should be doing differently.

"set editing-mode vi" definitely won't make it into the base distribution
though, it's impossible for total newbies to handle (and people who like
it usually know how to turn it on themselves).

LLaP
bero


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
