Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWF2IFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWF2IFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWF2IFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:05:17 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:27877 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751677AbWF2IFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:05:15 -0400
Date: Thu, 29 Jun 2006 10:04:57 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Matt LaPlante <laplam@rpi.edu>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attack of "the the"s in /arch
Message-ID: <20060629100457.4ed45d7e@localhost>
In-Reply-To: <20060629024805.63f8054c.laplam@rpi.edu>
References: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
	<20060628213924.50f29a4a.rdunlap@xenotime.net>
	<20060629011651.1543b42b.laplam@rpi.edu>
	<20060628230305.c9eaf6a9.rdunlap@xenotime.net>
	<20060629024805.63f8054c.laplam@rpi.edu>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 02:48:05 -0400
Matt LaPlante <laplam@rpi.edu> wrote:

> I'll CC: to Linus and hope for the best.

Since Linus receives a lot of mails the best option was to send it to
"trivial@kernel.org":

Documentation/SubmittingPatches:
-----
For small patches you may want to CC the Trivial Patch Monkey
trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
patches. Trivial patches must qualify for one of the following rules:
 Spelling fixes in documentation
 Spelling fixes which could break grep(1).
 Warning fixes (cluttering with useless warnings is bad)
...
-----

:)

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
