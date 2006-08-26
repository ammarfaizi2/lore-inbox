Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945897AbWHZLBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbWHZLBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 07:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945898AbWHZLBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 07:01:09 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:30174
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1945897AbWHZLBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 07:01:08 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.16.28
Date: Sat, 26 Aug 2006 13:00:30 +0200
User-Agent: KMail/1.9.1
References: <20060826003639.GA4765@stusta.de>
In-Reply-To: <20060826003639.GA4765@stusta.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261300.30873.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 August 2006 02:36, Adrian Bunk wrote:
> Security fixes since 2.6.16.27:
> - CVE-2006-2935: cdrom: fix bad cgc.buflen assignment
> - CVE-2006-3745: Fix sctp privilege elevation
> - CVE-2006-4093: powerpc: Clear HID0 attention enable on PPC970 at boot time
> - CVE-2006-4145: Fix possible UDF deadlock and memory corruption
> 
> 
> Location:
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
> 
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> 
> RSS feed of the git tree:
> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss

Why isn't there an incremental patch-2.6.16.27-28.bz2 available
in ftp://ftp.kernel.org/pub/linux/kernel/v2.6/incr ?

-- 
Greetings Michael.
