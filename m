Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVKBPaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVKBPaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVKBPaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:30:21 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:12049 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S965082AbVKBPaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:30:19 -0500
To: Alex Lyashkov <umka@sevcity.net>
Cc: Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       linux-kernel@vger.kernel.org, "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
References: <XFMail.20051102104916.pochini@shiny.it>
	<1130943242.3367.39.camel@berloga.shadowland>
From: Nix <nix@esperi.org.uk>
X-Emacs: there's a reason it comes with a built-in psychotherapist.
Date: Wed, 02 Nov 2005 15:29:38 +0000
In-Reply-To: <1130943242.3367.39.camel@berloga.shadowland> (Alex Lyashkov's
 message of "2 Nov 2005 14:55:14 -0000")
Message-ID: <87fyqfm5jx.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2005, Alex Lyashkov moaned:
>> > So despite the fact the driver has been written in c++, it
>> > might be possible to write a usable specification.
>> 
>> Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.
>> You should ask them if you can publish your own driver based
>> on infos you extract from their driver.
>> 
> without exeption c++ code can be used at drivers.

The rather important `struct class' may give you trouble there.

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
