Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTIPMMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbTIPMMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:12:45 -0400
Received: from gprs149-223.eurotel.cz ([160.218.149.223]:6274 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261837AbTIPMMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:12:44 -0400
Date: Tue, 16 Sep 2003 14:12:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Mathieu LESNIAK <maverick@eskuel.net>, LKML <linux-kernel@vger.kernel.org>,
       mochel@osdl.org
Subject: Re: Nearly succes with suspend to disk in -test5-mm2
Message-ID: <20030916121229.GE585@elf.ucw.cz>
References: <3F660BF7.6060106@eskuel.net> <20030916114822.GB602@elf.ucw.cz> <1063714222.1302.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063714222.1302.5.camel@teapot.felipe-alfaro.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > cat you try with echo 4 > /proc/acpi/sleep?
> 
> It does nothing for me... No messages in the kernel ring, no intention
> to perform a swsusp.

That's strange; can you cat /proc/acpi/sleep?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
