Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCTOCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCTOCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 09:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVCTOCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 09:02:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52397 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261218AbVCTOCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 09:02:05 -0500
Date: Sun, 20 Mar 2005 15:01:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: af_unix.c, KBUILD_MODNAME and unix
In-Reply-To: <20050320135207.A12839@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0503201501410.31392@yvahk01.tjqt.qr>
References: <aec7e5c305032005451899b18b@mail.gmail.com>
 <20050320135207.A12839@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello All,
>> 
>> af_unix.c is currenty built with KBUILD_MODNAME=unix. This seems to
>> Solution? #undef unix?
>
>or maybe -Uunix ?

Why is not KBUILD_MODNAME=af_unix ?



Jan Engelhardt
-- 
