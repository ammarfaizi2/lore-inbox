Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTDGUgm (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTDGUgm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:36:42 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:38034 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S261831AbTDGUgl (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:36:41 -0400
Date: Mon, 7 Apr 2003 13:48:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030407204812.GD17151@ip68-0-152-218.tc.ph.cox.net>
References: <20030407171037.GB8178@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407171037.GB8178@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 07:10:37PM +0200, J?rn Engel wrote:

> Some days ago, I've started a -je [*] tree which will focus on memory
> reduction for the linux kernel.

First, I'd like to say please, no, everyone can benefit from _every
change_ you want to make in your tree, and it's not just an 'embedded'
issue.

Second, please look up the archives (this past June -> August maybe?)
for the CONFIG_TINY thread.  Under that was my TWEAKS idea.  If this
sounds useful to you, I can try and dig up the last patch I had that got
all of the dependancy stuff correct, except that you had to run a
command if you changed a TWEAK value.

-- 
Tom Rini
http://gate.crashing.org/~trini/
