Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTEZFC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTEZFC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:02:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5136 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264265AbTEZFCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:02:55 -0400
Date: Sun, 25 May 2003 22:15:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <20030526045833.GA27204@gtf.org>
Message-ID: <Pine.LNX.4.44.0305252214290.6692-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:
>
> Just to echo some comments I said in private, this driver is _not_
> a replacement for drivers/ide.  This is not, and has never been,
> the intention.  In fact, I need drivers/ide's continued existence,
> so that I may have fewer boundaries on future development.

Just out of interest, is there any _point_ to this driver? I can
appreciate the approach, but I'd like to know if it does anything (at all)
better than the native IDE driver? Faster? Anything?

		Linus

