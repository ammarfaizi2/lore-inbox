Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVHGBGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVHGBGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVHGBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:06:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34694 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261396AbVHGBGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:06:32 -0400
Date: Sat, 6 Aug 2005 18:06:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Maurer <martinmaurer@gmx.at>
Cc: stern@rowland.harvard.edu, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
Message-Id: <20050806180608.0ecab568.zaitcev@redhat.com>
In-Reply-To: <200508070222.57340.martinmaurer@gmx.at>
References: <20050805151820.3f8f9e85.akpm@osdl.org>
	<Pine.LNX.4.44L0.0508061137180.1168-100000@netrider.rowland.org>
	<20050806130217.1748f7be.zaitcev@redhat.com>
	<200508070222.57340.martinmaurer@gmx.at>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005 02:22:53 +0200, Martin Maurer <martinmaurer@gmx.at> wrote:

> when i delete the files which are on the stick and do an umount/mount
> cycle, the files are there again. 
> Copying files to the stick gives wrong results too.

Curious. First of all, I have a request: do not call this device a "stick".
It is terribly misleading word with which to call a fully-featured MP3
player. DNT uses it in a specific context, as a product name.

I'd like to have a usbmon trace of a session, from plugging, through
copying, through unplugging. Do not send it to the whole cc: list.
Do you need instructions?

-- Pete
