Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVGAXhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVGAXhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGAXhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:37:02 -0400
Received: from peabody.ximian.com ([130.57.169.10]:30157 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261624AbVGAXg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:36:57 -0400
Subject: Re: [-mm patch] inotify: fsnotify.h: use kstrdup
From: Robert Love <rml@novell.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050701225559.GC3592@stusta.de>
References: <20050701225559.GC3592@stusta.de>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 19:36:56 -0400
Message-Id: <1120261016.7270.25.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 00:55 +0200, Adrian Bunk wrote:

> kstrdup was added in 2.6.13-rc1.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks.  I'll put this in the next release.

Andrew, you can merge this before then, if you want.

Signed-off-by: Robert Love <rml@novell.com>

	Robert Love


