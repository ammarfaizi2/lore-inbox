Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVLUUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVLUUOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVLUUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:14:35 -0500
Received: from khc.piap.pl ([195.187.100.11]:3332 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932396AbVLUUOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:14:35 -0500
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About 4k kernel stack size....
References: <20051218231401.6ded8de2@werewolf.auna.net>
	<43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>
	<170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	<BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE>
	<dobr1u$19t$1@sea.gmane.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 21 Dec 2005 21:14:20 +0100
In-Reply-To: <dobr1u$19t$1@sea.gmane.org> (Giridhar Pemmasani's message of
 "Wed, 21 Dec 2005 10:07:01 -0500")
Message-ID: <m3d5jq2oo3.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani <giri@lmc.cs.sunysb.edu> writes:

> As I see, although people that rely on
> ndiswrapper (since there is no other way they could use the hardware that
> they have) will not be able to use their wireless cards when this patch
> gets merged without having to patch the kernel

Huh? -mm is already a patch so I'm not sure what users are you talking
about. End-users (non-developers) using -mm kernel (binary?) provided
by their distribution? Why would they want to use ndiswrapper (= binary
drivers, which make all bug reports and in fact all development
pointless) with devel kernel?
-- 
Krzysztof Halasa
