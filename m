Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264975AbUFXNwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbUFXNwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUFXNwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:52:13 -0400
Received: from mail5-151.ewetel.de ([212.6.122.151]:30606 "EHLO
	mail5.ewetel.de") by vger.kernel.org with ESMTP id S264975AbUFXNvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:51:21 -0400
Date: Thu, 24 Jun 2004 15:51:11 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: using gcc built-ins for bitops?
In-Reply-To: <20040624134900.GG21376@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406241550490.325@neptune.local>
References: <2awGH-DF-17@gated-at.bofh.it> <E1BdUZ0-00004M-QC@localhost>
 <20040624134900.GG21376@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Arjan van de Ven wrote:

>> Eh, what value does __GNUC_MINOR__ have for, say, gcc-2.95.x?
> gcc 2.x.y do not use compiler-gcc3.h but compiler-gcc2.h instead so that is
> irrelevant ;)

Ah. Sorry for the noise.

-- 
Ciao,
Pascal
