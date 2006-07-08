Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWGHLmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWGHLmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGHLmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:42:08 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:50329 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S964791AbWGHLmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:42:07 -0400
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp /
	suspend2 reliability]
From: Bojan Smojver <bojan@rexursive.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
In-Reply-To: <200607082131.47832.ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <200607081342.40686.ncunningham@linuxmail.org>
	 <200607081238.16753.rjw@sisk.pl>
	 <200607082131.47832.ncunningham@linuxmail.org>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 21:42:03 +1000
Message-Id: <1152358923.2556.6.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 21:31 +1000, Nigel Cunningham wrote:

> It's only too slow on swsusp. With Suspend2, I regularly suspend 1GB images on 
> both my desktop and laptop machines. I agree that it might be slower on a 
> 4200RPM laptop drive, but you also have to balance this against faulting the 
> pages back in post resume (which will be slower because they're not 
> compressed and contiguous then, though maybe not not as noticable if you're 
> saving 75% of memory).

I'm one of those unlucky people with a 4200 RPM notebook drive, coupled
with a crappy P4 based Celeron CPU. By far, Suspend2 provides a better
user experience than swsusp, even when saving all of 700+ MB or RAM.

-- 
Bojan

