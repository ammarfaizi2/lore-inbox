Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVDFSFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVDFSFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 14:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVDFSFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 14:05:52 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44264 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262260AbVDFSFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 14:05:48 -0400
Subject: Re: 2.6.12-rc2-mm1: inotify and directory removal
From: Robert Love <rml@novell.com>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6uacocvy5a.fsf@zork.zork.net>
References: <6uacocvy5a.fsf@zork.zork.net>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 14:05:47 -0400
Message-Id: <1112810747.13601.17.camel@phantasy.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 14:21 +0100, Sean Neakums wrote:

> Using your glib sample thingy from
> http://www.kernel.org/pub/linux/kernel/people/rml/inotify/glib/

Thanks.  It was a bug in the glib utility, not inotify itself.

I fixed it in inotify-glib-0.0.2, which should appear at the above URL
as soon as the mirrors sync.

Thanks again!

	Robert Love


