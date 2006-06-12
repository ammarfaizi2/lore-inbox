Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWFLIrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWFLIrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFLIrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:47:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:48092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751124AbWFLIro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:47:44 -0400
X-Authenticated: #428038
Date: Mon, 12 Jun 2006 10:47:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Avi Kivity <avi@argo.co.il>
Cc: Rik van Riel <riel@redhat.com>, Theodore Tso <tytso@mit.edu>,
       David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060612084739.GD11649@merlin.emma.line.org>
Mail-Followup-To: Avi Kivity <avi@argo.co.il>,
	Rik van Riel <riel@redhat.com>, Theodore Tso <tytso@mit.edu>,
	David Woodhouse <dwmw2@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com> <448C2298.5000409@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448C2298.5000409@argo.co.il>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Avi Kivity wrote:

> Can't it be corrected by having the thunk.org MTA relay messages from 
> @mit.edu through the MIT MTA? Presumably the MIT MTA will only be open 
> to authenticated users.

That isn't "corrected", but "broken even further".

What difference does it to the authenticity of the message or perhaps
its envelope make who the postman is and into which mailbox the letter
is posted?

Use something sane please, not SPF.

All the world break their mailers at Wong's command because a half-baked
idea is raved about without thinking.

It's bad enough GMX are posting SPF records - I disabled SPF on my
inbound path, because GMX enable a per-recipient configuration of this
nonsense - I can't opt out of their posting SPF records though...

There's no need to repeat David's arguments counter to SPF for me.
David's document says it all.

-- 
Matthias Andree
