Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269535AbUI3Wpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269535AbUI3Wpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269598AbUI3Wpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:45:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:48068 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269535AbUI3Wpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:45:38 -0400
Subject: Re: [patch] inotify: rename inotify_watcher
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096584180.4203.91.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096584180.4203.91.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 18:44:15 -0400
Message-Id: <1096584255.4203.93.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 18:43 -0400, Robert Love wrote:

> s/inotify_watcher/inotify_watch/ per the TODO

Oh, BTW, there are many, many instances of "watcher" that probably ought
to be "watch" (same goes for "watchers" and "watches") but the patch was
huge.  I settled for at least getting the name of the structure right.

	Robert Love


