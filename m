Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUBQNf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUBQNf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:35:27 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:32615 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266166AbUBQNfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:35:24 -0500
Date: Tue, 17 Feb 2004 07:35:23 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Speaker static, vanishes with APIC
In-Reply-To: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
Message-ID: <Pine.LNX.4.58.0402170734340.1559@ryanr.aptchi.homelinux.org>
References: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Ryan Reich wrote:

> This is really trivial and I solved it anyway, but in all incarnations of 2.6 I
> have had static coming from my speakers shortly after boot.  It only lasts a few
> seconds and sounds as though someone were jiggling the plug in the sound card's
> socket.  It only happens right after boot.  Since I enabled Local APIC and
> IO-APIC it hasn't happened.
>
> Sound card module is snd-intel8x0, and my card is built into my Shuttle AN35N
> motherboard.

Spoke too soon, it's still there.  Though it definitely wasn't there last time I
booted.

-- 
Ryan Reich
ryanr@uchicago.edu
