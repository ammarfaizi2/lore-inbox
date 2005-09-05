Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVIEOOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVIEOOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIEOOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:14:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751262AbVIEOOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:14:23 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0509050946190.4369@cuia.boston.redhat.com> 
References: <Pine.LNX.4.63.0509050946190.4369@cuia.boston.redhat.com>  <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com> <26510.1125913723@warthog.cambridge.redhat.com> 
To: Rik van Riel <riel@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] fix for -mm add-sem_is_read-write_locked.patch 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Mon, 05 Sep 2005 15:14:10 +0100
Message-ID: <1797.1125929650@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:

> I really shouldn't make patches like this in the morning on weekends, 
> when I'm still sleepy.  Well, here is the trivial fix...

That would seem to fix that bit.

David
