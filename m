Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbULMTci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbULMTci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbULMTaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:30:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58760 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262273AbULMSST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:18:19 -0500
Date: Mon, 13 Dec 2004 19:17:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matan Peled <chaosite@gmail.com>
cc: Danny Beaudoin <beaudoin_danny@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Typo in kernel configuration (xconfig)
In-Reply-To: <41BDDB02.5020606@gmail.com>
Message-ID: <Pine.LNX.4.61.0412131917140.12936@yvahk01.tjqt.qr>
References: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
 <Pine.LNX.4.61.0412130925510.2394@yvahk01.tjqt.qr> <41BDDB02.5020606@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If I'm not at the right place, please forward this to the right person.
>> > 
>> > In Device Drivers/Graphics Support/Support for frame buffer devices:
>> > "On several non-X86 architectures, the frame buffer device is the
>> > only way to use the graphics hardware."
>> > 
>> > This should be 'x86' instead, as in the rest of the description.
>> 
>> What kind of typo is that?

> A nit picking one :)
> Besides, linux is case-sensitive, isn't it?

Depends where you look. In the code (C), yes, but the docs, I doubt.


Jan Engelhardt
-- 
ENOSPC
