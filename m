Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUB2MlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 07:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUB2MlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 07:41:10 -0500
Received: from gprs154-126.eurotel.cz ([160.218.154.126]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262044AbUB2MlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 07:41:08 -0500
Date: Sun, 29 Feb 2004 13:40:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040229124052.GB283@elf.ucw.cz>
References: <20040228230039.GA246@elf.ucw.cz> <1078012320.906.9.camel@gaston> <20040229072959.GB209@elf.ucw.cz> <1078039327.904.36.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078039327.904.36.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Except that pmdisk code is +/- readable, swsusp is not...
> > 
> > Would you be willing to either maintain pmdisk or (preffered) split it
> > up and submit me pieces?
> 
> Heh, if I had time ... :)

Well, unless someone steps up, I guess I'll just let it bitrot, and
when its broken enough, I'll attempt removal. I really do not have
time to maintain two implementations...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
