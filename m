Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUIUACc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUIUACc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUIUACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:02:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19943 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267409AbUIUACa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:02:30 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1040920180744.11755B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1040920180744.11755B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Mon, 20 Sep 2004 20:02:28 -0400
Message-Id: <1095724948.2454.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 18:59 -0400, Bill Davidsen wrote:

> I'm sorry you think think I'm talking to hear myself talk, the
> point I'm making is valid to me.

Judgment suggests I should drop this, but the problem is that you never
made a valid or well-informed point.

You started off with "Did you work for Microsoft?" and you followed up
with questions and critiques demonstrating no understanding whosoever
for the way that Linux dcache or inode management works and further that
you did not even read the patch.

My reply "well dnotify has this same issue" is not a rallying behind the
status quo (I mean, I want dnotify dead myself) but that no one
complains about the size issue with dnotify.  John and I want to address
the issues with dnotify.

If we can do something about space consumption, and if it turns out to
be an issue, I am all for it.  I do not yet see a way around it, and no
one has shown that normal use in the real world suffers from any issue.

Thanks,

	Robert Love


