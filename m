Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWAEJZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWAEJZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWAEJZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:25:31 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:55235 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750884AbWAEJZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:25:30 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: be-news06@lina.inka.de (Bernd Eckenfels)
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Date: Thu, 05 Jan 2006 20:25:25 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <6appr1djnkhaa35cjahs22itittduia9bf@4ax.com>
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de>
In-Reply-To: <E1EuPZg-0008Kw-00@calista.inka.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 08:30:16 +0100, be-news06@lina.inka.de (Bernd Eckenfels) wrote:

>Randy.Dunlap <rdunlap@xenotime.net> wrote:
>> This one delays each printk() during boot by a variable time
>> (from kernel command line), while system_state == SYSTEM_BOOTING.
>
>This sounds a bit like a aprils fool joke, what it is meant to do? You can
>read the messages in the bootlog and use the scrollback keys, no?

No, after oops, console dead, very dead . . . no scrollback :(

Just the image on the screen, until one hits the power or reset 
button.

Very sad,,,  You want a kernel monitor to baby boot process?

Grant.
