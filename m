Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVFAJhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFAJhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFAJhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:37:31 -0400
Received: from [203.171.93.254] ([203.171.93.254]:25032 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261357AbVFAJfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:35:41 -0400
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601090622.GB6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	 <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	 <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
	 <20050601081336.GA6693@elf.ucw.cz> <1117614857.19020.32.camel@gaston>
	 <20050601090622.GB6693@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117618614.14386.2057.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Jun 2005 19:36:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-06-01 at 19:06, Pavel Machek wrote:
> Seems like lots of stuff is going to happen in pm post-2.6.12: I'd
> like to finally fix pm_message_t, too...

Speaking of which, how do you want to move forward with the refrigerator
patches I sent you a while back?

Regards,

Nigel

