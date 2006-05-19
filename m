Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWESRwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWESRwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWESRwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:52:38 -0400
Received: from xenotime.net ([66.160.160.81]:12446 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751414AbWESRwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:52:38 -0400
Date: Fri, 19 May 2006 10:55:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format?
Message-Id: <20060519105506.1653d4ff.rdunlap@xenotime.net>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3262@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3262@chicken.machinevisionproducts.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 10:11:48 -0700 Brian D. McGrew wrote:

> My drivers are inline in this mail.  I'm still having this problem with
> the 2.6.16 kernel as where I'm not having it with the 2.6.15 kernel --
> and it's the same source code, compiled the same way.
> 
> Also, I'm still having difficulties getting this driver to work
> correctly so any help would be great!

to work?  Does it even build?

> #include "dev/rtc.h"
> #include "rtcsoft.h"

missing files.

---
~Randy
