Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTELPZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTELPZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:25:53 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:16900 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262226AbTELPZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:25:51 -0400
Date: Mon, 12 May 2003 17:37:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <20030512141619.GO1107@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0305121733010.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <20030512141619.GO1107@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 May 2003, Adrian Bunk wrote:

> A choice with the possibility to select one or more entries, to support 
> things like:
>   Supported processors:
>     [ ] 386
>     [ ] 486
>     [ ] 586
>     ...
> 
> It should be possible to select more than one item but selecting zero 
> items should be illegal.

I think that has to wait, supporting this properly would require too many 
changes and there are other ways to achieve almost the same.

bye, Roman

