Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUIONGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUIONGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIONEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:04:04 -0400
Received: from mp1-smtp-2.eutelia.it ([62.94.10.162]:12185 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S266034AbUIOM6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:58:04 -0400
Date: Wed, 15 Sep 2004 14:59:02 +0200
From: Luca Ferroni <fferroni@cs.unibo.it>
To: Patrick Kiwitter- Mailinglist <ccc@devilcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: monoholitic, hybrid or not monoholitic?
Message-Id: <20040915145902.77fda30a.fferroni@cs.unibo.it>
In-Reply-To: <4148271D.9050009@devilcode.de>
References: <4148271D.9050009@devilcode.de>
Organization: Ferrlabs
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Wed, 15 Sep 2004 13:27:25 +0200,  Patrick Kiwitter- Mailinglist <ccc@devilcode.de> ha scritto:

> the kernel were mostly descripted as monoholitic. but some sources means
> that the linux kernel is not really monoholitic because of the feature
> of loading kernel modules. some pages are talking about a "hybrid
> kernel" which means that the kernel is a glue one, a little bit of
> monoholitic and a little bit not.
> 

I think Linux kernel should be considered monoholitic anyway,
because, even it can load kernel modules, they execute themselves
in kernel privileged space.
You can compile some kernel parts as modules, 
so they belong to the Linux core, the only difference is that they
are loaded on demand implying all benefits and disadvantages we know.

Bye
Luca

-- 
----------------------------------------
They'll never steal us our .... FREEDOM!!!
Luca Ferroni
ICQ #317977679
www.cs.unibo.it/~fferroni/
----------------------------------------
