Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVESRje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVESRje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVESRje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:39:34 -0400
Received: from [81.2.110.250] ([81.2.110.250]:37002 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261184AbVESRjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:39:11 -0400
Subject: RE: Illegal use of reserved word in system.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gilbert, John" <JGG@dolby.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B08670@bronze.dolby.net>
References: <2692A548B75777458914AC89297DD7DA08B08670@bronze.dolby.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116524233.21358.292.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 May 2005 18:37:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-05-18 at 22:31, Gilbert, John wrote:
> #JG
> Sorry, I was borrowing the term from the g++ error that this created.
> I'm not trying to imply that someone should be arrested. ;^) Also, like
> a few people have already mentioned, it doesn't effect the kernel at all
> as it's strictly a C program.

And that wants submitting to the GNU compiler people as a bug I guess ;)

MySQL using kernel headers is a bit sad given that the same macros were
put into proper user mode headers and under even more open licenses by
the Mozilla people with Linus permission.

DRI one does seem to be a real bug.

Alan

