Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWI0Acf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWI0Acf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWI0Acf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:32:35 -0400
Received: from xenotime.net ([66.160.160.81]:46228 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750811AbWI0Ace (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:32:34 -0400
Date: Tue, 26 Sep 2006 17:33:47 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
 acpi_pm clocksource has been installed.
Message-Id: <20060926173347.04fd66dd.rdunlap@xenotime.net>
In-Reply-To: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:

> I get this in dmesg with 2.6.18-git6 :
>       a3:<6>Time: acpi_pm clocksource has been installed.
> 
> Looks like some printk() somewhere is not adding \n correctly after
> outputting a message priority or a message priority too much is
> used... I've not investigated where this happens, but just wanted to
> report it.

Hi,
How about posting (pasting) some of the message log before that?

---
~Randy
