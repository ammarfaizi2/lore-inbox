Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753660AbWKENye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbWKENye (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbWKENye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:54:34 -0500
Received: from khc.piap.pl ([195.187.100.11]:23247 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1753623AbWKENye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:54:34 -0500
To: "Dmitry Bohush" <dmitrij.bogush@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitch noise on Acer Aspire 5602WLMi
References: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 05 Nov 2006 14:54:31 +0100
In-Reply-To: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com> (Dmitry Bohush's message of "Sun, 5 Nov 2006 08:57:09 +0200")
Message-ID: <m3veluuhgo.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry Bohush" <dmitrij.bogush@gmail.com> writes:

> Hello,  Probably it is one of resistors on motherboard. This noise
> goes away with adding acpi=off to boot params.

Interesting but resistors usually don't make any noise.
Capacitors, sometimes.
-- 
Krzysztof Halasa
