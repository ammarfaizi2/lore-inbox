Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933804AbWKTAUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933804AbWKTAUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933803AbWKTAUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:20:07 -0500
Received: from raven.upol.cz ([158.194.120.4]:35479 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S933806AbWKTAUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:20:06 -0500
Date: Mon, 20 Nov 2006 00:26:30 +0000
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [e-mail problems] with infradead.org recipients
Message-ID: <20061120002630.GB16937@flower.upol.cz>
References: <slrnem0qco.fp5.olecom@flower.upol.cz> <45609CA9.8030806@garzik.org> <1163962173.6925.70.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163962173.6925.70.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-19, David Woodhouse wrote:
[]
> I don't see either of those connection attempts in the logs for
> canuck.infradead.org. Canuck is on GMT-5, and I've looked in its logs
> for a few minutes around 08:27 and around 06:49. Nothing seems to match
> your sender address.

Yes. I've told about DNS and IP, but forgot to show logs.

On time of writing first message, there was no DNS answer from root
servers about infradead; now i see ns0 on infradead.org request and ns0,
ns1, ns2 servers on canuck.infradead.org, ping is working, i can connect
to ports. Week or so ago there was "no route to host" problem. Because of
sending via smarthost and blocked outgoing 25 port, this all i can say.
____
