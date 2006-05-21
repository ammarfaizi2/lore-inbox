Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWEUTtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWEUTtS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEUTtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:49:18 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:16275 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964930AbWEUTtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:49:17 -0400
Date: Sun, 21 May 2006 12:49:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, levon@movementarian.org,
       phil.el@wanadoo.fr, Andrew Morton <akpm@osdl.org>
Subject: Is OPROFILE actively maintained?
Message-ID: <20060521194915.GA2153@taniwha.stupidest.org>
References: <20060520025322.GD9486@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520025322.GD9486@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 07:53:22PM -0700, Chris Wedgwood wrote:

> oprofile isn't new and a lot of developers use it.  Drop the
> EXPERIMENTAL.

Some feedback claims this is not the case and that "it's unmaintained,
rarely well-tested, and may still need changes for some forthcoming
JVM stuff. and the tools aren't yet at 1.0".

Given that it should probably stay EXPERIMENTAL for now.  I wonder if
left unmaintained for much longer if it should be potentially marked
BROKEN and/or scheduled for removal?

MAINTAINERS claims it is maintained, if that is not long the case I'm
happy post a trivial patch to change that.  Or perhaps we can find a
new maintainer?
