Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbTGLD3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbTGLD3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:29:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267425AbTGLD3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:29:20 -0400
Date: Fri, 11 Jul 2003 20:44:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: update the i810 audio driver
In-Reply-To: <200307111814.h6BIEgXZ017350@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307112041060.4337-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Alan Cox wrote:
> -	   separately as nocache. Must be 8 byte aligned */
> +	   seperately as nocache. Must be 8 byte aligned */

Ok, Alan, spot the problem.

		Linus

