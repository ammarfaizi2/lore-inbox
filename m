Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWGHE6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWGHE6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 00:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWGHE6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 00:58:33 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:28825 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1750951AbWGHE6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 00:58:32 -0400
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp /
	suspend2 reliability]
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       jan@rychter.com, Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
In-Reply-To: <20060708002826.GD1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 14:58:28 +1000
Message-Id: <1152334708.2497.10.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 02:28 +0200, Pavel Machek wrote:

> uswsusp makes suspend2 obsolete, and suspend2 now looks
> misdesigned. It puts too much stuff into the kernel, you know that
> already.

In order for uswsusp to make Suspend2 obsolete, it would have to *at
least* support what Suspend2 does. Unfortunately, that isn't the case
right now.

When can we expect all that in uswsusp?

-- 
Bojan

