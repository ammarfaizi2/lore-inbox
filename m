Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTKXQuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 11:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTKXQuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 11:50:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:25321 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263777AbTKXQuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 11:50:05 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 24 Nov 2003 17:30:13 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test10] standby freezes bttv
Message-ID: <20031124163013.GA32212@bytesex.org>
References: <200311241420.08216.mbuesch@freenet.de> <20031124134212.GE30618@bytesex.org> <200311241645.05926.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311241645.05926.mbuesch@freenet.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In file included from drivers/media/video/bttv-driver.c:39:
> drivers/media/video/bttvp.h:44:29: media/ir-common.h: No such file or directory

That is in the 25_ir_input-2.6.0-test8.diff.gz patch ...

> As I'm using test-10, do you have updated patches?

just uploaded.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
