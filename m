Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVA3WfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVA3WfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVA3WfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:35:15 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:6265 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261816AbVA3WfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:35:10 -0500
Date: Sun, 30 Jan 2005 23:36:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Kconfig: cleanup the menu structure
Message-ID: <20050130223655.GF14816@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292301470.7147@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501292301470.7147@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 11:18:26PM +0100, Roman Zippel wrote:
> Hi,
> 
> The following patches cleans up some of the worst offenders, which mess up 
> the kconfig menu structure.

I have applied all 8 patched - using the latest version you posted for
input. If more work is need for input then it should be on top of this
patch.

The pach below I have not looked into.

Thanks for doing this cleaning.

	Sam
