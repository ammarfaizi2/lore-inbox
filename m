Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270895AbUJUTws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270895AbUJUTws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270919AbUJUTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:48:46 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:2944 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270895AbUJUThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:37:19 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Pavel Machek <pavel@ucw.cz>
Date: Thu, 21 Oct 2004 12:36:59 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4177AD6B.23151.20F0292D@localhost>
In-reply-to: <20041020191044.GB21315@elf.ucw.cz>
References: <41764FB3.29782.1B9A13F4@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> One more question: Does 0xc0000 POST method work even on
> notebooks? On regular machines, PCI card must have normal bios and
> stuff is easy. On notebooks there was talk about "integrated bios"
> where it really has no video bios at all and system bios POSTs the
> card. Have you seen that? 

We have never had a need to POST a notebook Video BIOS so I don't know 
what would happen. It is an interesting question, and if this is to be 
used for resume operations something that should be investigated.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


