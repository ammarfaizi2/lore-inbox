Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUGBSMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUGBSMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUGBSMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:12:37 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:40103 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S264726AbUGBSMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:12:34 -0400
Subject: Re: 2.6.7-mm5
From: Dax Kelson <dax@gurulabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040630172656.6949ec60.akpm@osdl.org>
References: <20040630172656.6949ec60.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088791945.3808.3.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 02 Jul 2004 12:12:25 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 18:26, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/
> 
> - bk-acpi.patch is back.  If devices mysteriously fail to function please
>   try reverting it with
> 
>        patch -p1 -R -i ~/bk-acpi.patch

Just some positive feedback. I tried this on my brand new IBM Thinkpad
T42p and nothing regressed.

I do have a problem with PCMCIA/CardBus not working with the FC2 kernel
(kernel-2.6.6-1.435.2.1) I tried 2.6.7-mm5 in hopes of it working, but
alas it is still borked.

Dax

