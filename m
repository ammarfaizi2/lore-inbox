Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWIUOk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWIUOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWIUOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:40:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:43703 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750991AbWIUOk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:40:27 -0400
Date: Thu, 21 Sep 2006 16:39:49 +0200
From: Stefan Seyfried <seife@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Marek Vasut <marek.vasut@gmail.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Message-ID: <20060921143949.GA9581@suse.de>
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com> <20060920145006.05117085.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060920145006.05117085.akpm@osdl.org>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-rc6-2-seife
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 02:50:06PM -0700, Andrew Morton wrote:
> On Wed, 20 Sep 2006 17:29:43 -0400
> "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> > > input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
> > > i8042-activate-panic-blink-only-in-x.patch
> > 
> > There was a concern that blinking is useful even when not running X.
> > Do you have any input?
> 
> No, sorry.

I found it useful for machines panicking after suspend-to-ram with the
video still dark.
I have, however, not seen a machine panicking on resume for quite some
time. They just hang :-)

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
