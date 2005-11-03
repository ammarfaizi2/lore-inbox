Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVKCSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVKCSmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVKCSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:42:38 -0500
Received: from mail.capitalgenomix.com ([143.247.20.203]:18125 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1030419AbVKCSmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:42:37 -0500
Date: Thu, 3 Nov 2005 13:43:13 -0500
From: sean.fao@capitalgenomix.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kconfig and lxdialog, kernel 2.6.13.4
Message-ID: <20051103184313.GA11390@cgx-mail.capitalgenomix.com>
References: <4360FB36.1080404@capitalgenomix.com> <Pine.LNX.4.61.0510272307050.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510272307050.1386@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Thank you for all of your feedback.  It is much appreciated.  Also, I
apologize for not getting back to you sooner; I got held up on a lot
of stuff at work.

On Thu, Oct 27, 2005 at 11:11:52PM +0200, Roman Zippel wrote:
> 
> On Thu, 27 Oct 2005, Fao, Sean wrote:
> 
> > http://www2.capitalgenomix.com/temp/linux_patch/format_patch
> 
> Looks fine, but you could also please manually cleanup the parts which got 
> too much indented to the right. Usually one tries to move them into 
> separate functions, but sometimes exceeding the 80 char limit is IMO fine 
> too.

Here is an updated patch for the updated 2.6.14 kernel.  Please note,
however, that I have not done any cleanup because I wanted to know
your opinion, first.  Would you rather I try to format my changes
the same as the *original* lxdialog style, or include the styling changes
in a separate patch and leave my formatting the way it is?  I realize
that it's usually against common curtesy to modify the style, so I'll
take whatever advise you can give me on this.

http://www2.capitalgenomix.com/temp/linux_patch/format.patch

-- 
Sean

