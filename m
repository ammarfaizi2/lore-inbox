Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUJQSMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUJQSMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUJQSL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:11:57 -0400
Received: from findaloan.ca ([66.11.177.6]:23427 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S269256AbUJQSLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:11:43 -0400
Date: Sun, 17 Oct 2004 14:06:31 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017180631.GA11531@mark.mielke.cc>
Mail-Followup-To: Buddy Lucas <buddy.lucas@gmail.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017172244.GM7468@marowsky-bree.de> <5d6b657504101710542e054f53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6b657504101710542e054f53@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 07:54:04PM +0200, Buddy Lucas wrote:
> > This isn't per se the same as saying that it's not a sensible violation,
> > but very clearly the specs disagree with the current Linux behaviour.
> So document it.

This is all I'm expecting to see. :-)

Buddy: You took the opposite stance, but still stuck to the truth. I give
you points for that.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

