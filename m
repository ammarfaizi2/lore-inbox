Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSBVQ2p>; Fri, 22 Feb 2002 11:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292627AbSBVQ2e>; Fri, 22 Feb 2002 11:28:34 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:45552 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S288896AbSBVQ2Y>;
	Fri, 22 Feb 2002 11:28:24 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, Petro <petro@auctionwatch.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <20020213211639.GB2742@auctionwatch.com> <3C6B2277.CA9A0BF8@mandrakesoft.com> <3C6B406E.1010706@candelatech.com> <3C6B4B20.FE4AE960@mandrakesoft.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 22 Feb 2002 17:27:00 +0100
In-Reply-To: Jeff Garzik's message of "Thu, 14 Feb 2002 00:29:04 -0500"
Message-ID: <d3sn7ttrcb.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Soon but not terribly soon.  Intel has been responsive to feedback from
> Andrew Morton and myself.  Once it passes our review and Intel's
> testing, it will go in.  eepro100 will live on for a while, until we are
> certain e100 is stable, though.  (and eepro100 won't disappear from 2.4
> at all)

Would be a lot nicer to see someone spending the time pulling the
useful bits out of e100 and putting it into eepro100. e100 is ugly and
bloated for no reason.

Jes
