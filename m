Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVDKQNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVDKQNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDKQKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:10:31 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:20193 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261825AbVDKQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:00:33 -0400
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH encrypted swsusp 3/3] documentation
To: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 11 Apr 2005 18:00:08 +0200
References: <3RUc9-679-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DL1Kg-0000sc-BX@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:

> +If you want to store your suspend image encrypted with a temporary
> +key to prevent data gathering after resume you must compile
> +crypto and the aes algorithm into the kernel - modules won't work
> +as they cannot be loaded at resume time.

Can't that be ensured by selecting these options?
-- 
A man inserted an advertisement in the classified: Wife Wanted."
The next day he received a hundred letters. They all said the
same thing: "You can have mine."
Friﬂ, Spammer: arthropod@traders-briefing.de mailing@myph.biz
