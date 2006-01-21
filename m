Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWAUVHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWAUVHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAUVHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:07:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44165 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932352AbWAUVHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:07:08 -0500
Date: Sat, 21 Jan 2006 22:07:06 +0100
From: Olaf Hering <olh@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121210706.GB19221@suse.de>
References: <200601212207.49483.arvidjaar@mail.ru> <20060121191140.GA17661@suse.de> <200601212247.14101.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200601212247.14101.arvidjaar@mail.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 21, Andrey Borzenkov wrote:

> > no, cc-version is not expanded in this context.

> So again - does scripts/gcc-version.sh returns any usable value? Is it 
> executable?

As I said, its not called at all in this context.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
