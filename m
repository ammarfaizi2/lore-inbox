Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVF1Vjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVF1Vjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVF1Vjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:39:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11967 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262182AbVF1VjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:39:02 -0400
Subject: Re: [patch] latest inotify.
From: Robert Love <rml@novell.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <Pine.LNX.4.63.0506282322000.7125@alpha.polcom.net>
References: <1119989024.6745.20.camel@betsy>
	 <Pine.LNX.4.63.0506282322000.7125@alpha.polcom.net>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 17:39:06 -0400
Message-Id: <1119994746.6745.28.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 23:31 +0200, Grzegorz Kulewski wrote:

> 0aa3dfb1940a12a4245ec87b4246db85b55abe40  inotify-0.23-rml-2.6.12-rc4-8.patch

Oh, I just noticed this.

Can you please try with this latest release
(inotify-0.23-rml-2.6.12-14.patch)?

There is some code that might fix this for you, or reveal further what
is going on.

	Robert Love


