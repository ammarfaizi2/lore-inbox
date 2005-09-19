Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVISQ2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVISQ2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVISQ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:28:41 -0400
Received: from khc.piap.pl ([195.187.100.11]:10500 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932451AbVISQ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:28:40 -0400
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
References: <m364szk426.fsf@defiant.localdomain>
	<9a874849050917174635768d04@mail.gmail.com>
	<m3d5n7kwwz.fsf@defiant.localdomain>
	<20050919071521.GB14601@merlin.emma.line.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Sep 2005 18:28:38 +0200
In-Reply-To: <20050919071521.GB14601@merlin.emma.line.org>
Message-ID: <m38xxt58eh.fsf@defiant.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> One of Linux's main problems is that all daemons that drive kernel core
> functionality are cluttered over various separate projects. While this
> allows for independent development, it's annoying if you need to hunt
> down the various daemons (udev, autofs, hotplug, iproute, to name the
> first that come to mind) only to find out the new version doesn't suit
> your distro. I'd rather wish there was a standard kernel "daemons"
> package.

Who would select what is a standard kernel daemon and what is not?
Who would maintain the package?

> Why should other projects that recycle kernel code impact how the kernel
> itself is made.

It's NOT kernel code.
-- 
Krzysztof Halasa
