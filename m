Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWAZOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWAZOop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWAZOop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:44:45 -0500
Received: from twin.jikos.cz ([213.151.79.26]:21141 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751352AbWAZOon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:44:43 -0500
Date: Thu, 26 Jan 2006 15:44:41 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation for /dev/tun
In-Reply-To: <20060126140402.GB13403@kestrel>
Message-ID: <Pine.LNX.4.58.0601261543000.15286@twin.jikos.cz>
References: <20060126140402.GB13403@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Karel Kulhavy wrote:

> I have /dev/tun on my system and would like to read documentation about
> it. Because I already know that /dev/ttyS0 has manual page under man
> ttyS, I typed man tun No manual entry for tun also info tun No menu item
> `tun' in node `(dir)Top'. I also tried "tun" and "/dev/tun" at Wikipedia
> and they have nothing.

Documentation/networking/tuntap.txt
drivers/net/tun.c is quite easy to read too.

-- 
JiKos.
