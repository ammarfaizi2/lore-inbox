Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271250AbRHOP7r>; Wed, 15 Aug 2001 11:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271248AbRHOP71>; Wed, 15 Aug 2001 11:59:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37387 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271247AbRHOP7W>; Wed, 15 Aug 2001 11:59:22 -0400
Subject: Re: Oops on 2.2.19, Athlon 1ghz
To: natecars@real-time.com (Nate Carlson)
Date: Wed, 15 Aug 2001 17:01:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0108150904070.22267-400000@enchanter.real-time.com> from "Nate Carlson" at Aug 15, 2001 09:16:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X37F-0003Q6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> probable hardware bug: clock timer configuration lost - probably a VIA686a.
> probable hardware bug: restoring chip configuration.

That one is fine, its a sanity check and even if mistriggered is harmless

