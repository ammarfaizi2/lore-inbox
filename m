Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVHBH4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVHBH4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVHBH4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:56:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:34268 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261413AbVHBH4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:56:44 -0400
Date: Tue, 2 Aug 2005 09:56:40 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc5
Message-ID: <20050802075640.GA1666@suse.de>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 01, Linus Torvalds wrote:

> Give it a good testing, I'm hoping this can really turn into 2.6.13.

aic doesnt work anymore, the poweroff thing should also be fixed in some
way.

http://marc.theaimsgroup.com/?l=linux-scsi&m=112180348617932&w=2

(google did not find that posting, but it did find the commit to
http://www.kernel.org/pub/linux/kernel/people/jejb/scsi-misc-2.6.changelog
)
