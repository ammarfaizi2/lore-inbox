Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbTE0UyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTE0Uxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:53:50 -0400
Received: from users.eiwaz.com ([216.243.209.216]:3552 "EHLO users.eiwaz.com")
	by vger.kernel.org with ESMTP id S264161AbTE0Uxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:53:30 -0400
Subject: Re: Linux 2.5.70
From: Andreas Boman <aboman@nerdfest.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0305271245290.4448-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0305271245290.4448-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Message-Id: <1054069573.580.7.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 27 May 2003 17:06:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 12:58, Ricky Beam wrote:
<SNIP>
> Take a look at the number of arch's that haven't seen much testing (and
> in many respects are thus broken)... does anyone have a functional 2.5.70
> sparc64 kernel?  I've built several but they're all too big to be booted
> (i.e. over 3.5M, and yes, I've turned off everything possible.)
> --Ricky
> 

aboman@griffin:~> uname -a
Linux griffin 2.5.70 #1 Tue May 27 16:53:08 EDT 2003 sparc64 unknown unknown GNU/Linux

aboman@griffin:~> ls -lh /boot/vmlinux-2.5.70 
-rwxrwxr-x    1 root     root         2.6M May 27 16:57 /boot/vmlinux-2.5.70

regards, 
	Andreas

