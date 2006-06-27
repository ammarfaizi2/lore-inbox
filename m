Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWF0LUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWF0LUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWF0LUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:20:34 -0400
Received: from nn8.excitenetwork.com ([207.159.120.62]:42791 "EHLO myway.com")
	by vger.kernel.org with ESMTP id S932229AbWF0LUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:20:33 -0400
To: alan@lxorguk.ukuu.org.uk, samuelkorpi@myway.com
Subject: Re: Calling kernel functions from kprobes/jprobes
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 67d9deadc6717fb23d486b0daa7f46a6
Reply-To: samuelkorpi@myway.com
From: "Samuel Korpi" <samuelkorpi@myway.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060627112035.E517B67691@mprdmxin.myway.com>
Date: Tue, 27 Jun 2006 07:20:35 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 --- On Tue 06/27, Alan Cox < alan@lxorguk.ukuu.org.uk > wrote:

> Not all symbols are visible or kept. If you want to explore the internals of the
> kernel in more depth like this you might find building user mode linux with 
> debugging enabled and using gdb is both easier and a lot more fun.

Hmm. I´ll have to take a look at that. http://user-mode-linux.sourceforge.net/ seems to have something on the subject. Are there any other good places to look for info (tutorials etc.)?

However, just to make things clear - is there any way of finding out which symbols are visible to kernel modules?

Br,

Samuel Korpi

_______________________________________________
No banners. No pop-ups. No kidding.
Make My Way  your home on the Web - http://www.myway.com


