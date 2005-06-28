Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVF1VlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVF1VlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVF1VlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:41:19 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9919 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261295AbVF1VhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:37:05 -0400
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
Date: Tue, 28 Jun 2005 17:37:08 -0400
Message-Id: <1119994628.6745.26.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 23:31 +0200, Grzegorz Kulewski wrote:

> Are you aware of the following:

Yup.

Am tracking it at http://bugzilla.kernel.org/show_bug.cgi?id=4796

You are actually triggering a BUG(), which is helpful (and hopefully
related).

Also, Anton fixed some NTFS-related issues that should be in the next
2.6-mm.  Please do report back if that works or not.

	Robert Love


