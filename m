Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265254AbUFAVpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUFAVpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUFAVpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:45:38 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:6638 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S265254AbUFAVpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:45:25 -0400
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<200406011351.10669@zodiac.zodiac.dnsalias.org>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Tue, 01 Jun 2004 14:45:19 -0700
In-Reply-To: <200406011351.10669@zodiac.zodiac.dnsalias.org> (message from
 Alexander Gran on Tue, 1 Jun 2004 13:51:08 +0200)
Message-ID: <87d64jrlzk.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> writes:

> Am Dienstag, 1. Juni 2004 11:15 schrieb Andrew Morton:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6
>>.7-rc2-mm1/
>
> I can neither enter nor activate the gigabit ethernet driver section in 
> menuconfig

you need to turn on support for Ethernet (10 or 100Mbit). i had the
same problem on my laptop.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
