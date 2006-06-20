Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWFTRjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFTRjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWFTRjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:39:51 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:60648 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750728AbWFTRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:39:49 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] LED: add LED heartbeat trigger
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Richard Purdie <rpurdie@rpsys.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 20 Jun 2006 19:39:04 +0200
References: <6pRqN-5QK-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FskCC-000109-LV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> +       This allows LEDs to be controlled by a CPU load average.
> +       The flash frequency is a hyperbolic function of the 5-minute
> +       load average.
> +       If unsure, say Y.

Wouldn't the 1-minute-load be better?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
