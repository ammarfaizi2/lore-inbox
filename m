Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270425AbTGPIbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270412AbTGPIbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:31:14 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:31456 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270425AbTGPIYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:24:46 -0400
Date: Wed, 16 Jul 2003 10:37:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>, Kent Borg <kentborg@borg.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa
Message-ID: <20030716083758.GA246@elf.ucw.cz>
References: <20030715182117.BE2841675D3@smtp-out1.iol.cz> <20030715212210.GB10046@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715212210.GB10046@hell.org.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thus wrote pavel@ucw.cz:
> > Anyway, depending on acpi is wrong and needs to be fixed in 2.7.
> 
> Could you elaborate on that? Do you mean S4, or any suspend state in
> general?

It would be nice to have arch-neutral way to enter suspend to ram and
suspend to disk. Being arch-neutral, it may not depend on ACPI.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
