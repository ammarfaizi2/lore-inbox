Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVBJTZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVBJTZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVBJTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:24:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:8343 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261365AbVBJTWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:22:48 -0500
Date: Thu, 10 Feb 2005 20:23:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Steve Lee <steve@tuxsoft.com>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050210192319.GA1864@ucw.cz>
References: <000001c50f8f$7f420420$8119fea9@pluto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c50f8f$7f420420$8119fea9@pluto>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 10:42:15AM -0600, Steve Lee wrote:

> Roman, besides BK being closed source, how exactly is it lacking for
> your needs?  If what it lacks is a good idea and helps many, Larry and
> crew might be willing to add whatever it is you need.
 
A feature I lack is 'floating changesets', that would keep always at the
top of the history, rediffed, remerged and updated as other changesets
come in.

I know quilt can do it, but quilt can't do other things I like on bk.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
