Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272838AbTG3Lw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTG3Lw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:52:57 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:49046 "EHLO
	crl-mail.crl.dec.com") by vger.kernel.org with ESMTP
	id S272838AbTG3Lw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:52:56 -0400
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem
	ever
From: Jamey Hicks <jamey.hicks@hp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030729180005.GD2601@openzaurus.ucw.cz>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
	 <20030729180005.GD2601@openzaurus.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1059565549.27394.9.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 30 Jul 2003 07:45:49 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-0.5,
	required 5, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 14:00, Pavel Machek wrote:
> Hi!
> 
> I'd not said this is so pointless... handhelds tend to have "new mail" led for example.
> Better question is why it is not integrated with input subsystem (similar to kbd leds).

I would have thought that leds are output?  Why would output devices be
integrated into the input subsystem?

I do think that the Linux kernel should have a generic LED interface for
devices that have them available as indicators.

-Jamey


