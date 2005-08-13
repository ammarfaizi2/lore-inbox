Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVHMVG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVHMVG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 17:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHMVG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 17:06:28 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:20871 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932287AbVHMVG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 17:06:28 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Sun, 14 Aug 2005 07:06:13 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <4imsf11nt1t1dpmlp1vov5d62kpohopud8@4ax.com>
References: <200508131710.38569.annabellesgarden@yahoo.de> <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com> <42FE22BD.3050804@pobox.com>
In-Reply-To: <42FE22BD.3050804@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 12:41:33 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

>Grant Coady wrote:
>> I'm tracking a dataloss on box with this chip, finding it difficult 
>> to nail a configuration that reliably produces dataloss, sometimes 
>> only one bit (e.g. 'c' --> 'C') of unpacking kernel source tree gets 
>> changed.
...
>Just to eliminate one possibility, I would definitely switch out SATA 
>cables, which are notoriously crappy.

Since I have a spare new cable, done so.  But just now check SMART (in 
windows) and have zero UltraATA CRC Error rate (cable errors) for HDD.

Thanks,
Grant.

