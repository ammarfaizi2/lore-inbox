Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVJCUp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVJCUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVJCUp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:45:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:37779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932596AbVJCUp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:45:58 -0400
Date: Mon, 3 Oct 2005 13:45:25 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document patch subject line better
Message-ID: <20051003204525.GA17572@kroah.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com> <Pine.LNX.4.64.0510030805380.31407@g5.osdl.org> <20051003085414.05468a2b.pj@sgi.com> <20051003224010.4920b10e.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003224010.4920b10e.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 10:40:10PM +0200, Jean Delvare wrote:
> Hi Paul,
> 
> > I send patches directly from my quilt patches directory.  The patches
> > file ends up being -exactly- the email message body.  I did put in a
> > "---", with a short comment about how this patch fit in with the
> > earlier ones of yesterday, and removed the "Index: " and "========="
> > lines that quilt adds.
> 
> FYI, quilt 0.41 and above have a --no-index option to the refresh
> command, which will avoid this second annoyance. You can simply add the
> following to ~/.quiltrc:
> 
> QUILT_NO_DIFF_INDEX=1
> 
> And the default behavior will be changed to match Linus' requirements.

No, it still does not add the "---" line, right?

thanks,

greg k-h
