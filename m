Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWITRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWITRTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWITRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:19:18 -0400
Received: from xenotime.net ([66.160.160.81]:65464 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932067AbWITRTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:19:17 -0400
Date: Wed, 20 Sep 2006 10:20:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: drivers/char/random.c exported interfaces
Message-Id: <20060920102022.e58885df.rdunlap@xenotime.net>
In-Reply-To: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 13:04:43 -0400 Robin Getz wrote:

> Randy Dunlap said:
> >ISTM that we should at least fix the first 2 (by EXPORTing them).
> >or we don't allow INPUT=m.
> >
> >You want to send a patch?
> 
> No problem - which patch do you want? (exporting? or set INPUT to bool?)
> 
> I'll send the export later tonight if no objections.

I meant for exporting the 2 symbols that I had listed (was above).

Dmitry (cc-ed) can decide about INPUT being bool or not
and what problems it has.

---
~Randy
