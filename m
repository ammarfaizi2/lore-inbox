Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWJAVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWJAVxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWJAVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:53:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:7878 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932425AbWJAVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:53:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Sun, 1 Oct 2006 23:52:56 +0200
User-Agent: KMail/1.9.4
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <200609302237.22086.arnd@arndb.de> <200610010004.58984.rjw@sisk.pl>
In-Reply-To: <200610010004.58984.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610012352.57177.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 00:04, Rafael J. Wysocki wrote:
> Now that means some other ioctl definitions in kernel/power/power.h are
> wrong, but I'm not sure what I should do.
> 
> I think I'll just change the new definition and let the others stay as they
> are which is done in the appended patch.
> 

Ok, looks good now.

	Arnd <><
