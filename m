Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbULAW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbULAW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbULAW7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:59:15 -0500
Received: from mail.tmr.com ([216.238.38.203]:8713 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261485AbULAW7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:59:11 -0500
Date: Wed, 1 Dec 2004 17:49:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Schwab <schwab@suse.de>
cc: Jakub Jelinek <jakub@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
In-Reply-To: <je8y8t8n5t.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.3.96.1041201174645.26528F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Andreas Schwab wrote:

> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > Why can't you do dest=src? Assignment of struct to struct has been a part
> > of C since earliest times.
> 
> It's not a struct, it's an array (of one element of struct type).  You
> can't assign arrays.

I don't know what you read into my post, I said you can assign structs, I
didn't mention arrays. Other than you can assign elements of array of
struct, dest=src[index] format.

Why did you think I said array?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

