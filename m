Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTKHUDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTKHUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:03:41 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:41356 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262119AbTKHUDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:03:41 -0500
Date: Sat, 8 Nov 2003 12:03:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Weird ext2 problem in 2.4.18 (redhat)
Message-ID: <20031108200338.GA19486@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20031108063341.GA8349@work.bitmover.com> <20031108164410.GB2955@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108164410.GB2955@thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 11:44:10AM -0500, Theodore Ts'o wrote:
> If you notice the problem, you can also go in directly with debugfs
> and rename the errant directory entry directly.

Or you can reinstall :) I gave up and did so, Al got me nervous talking 
about rootkits and breakins and such.  If it happens agains I'll swap disk
drives if someone wants to poke at it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
