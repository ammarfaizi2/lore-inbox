Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264862AbUEJQru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbUEJQru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbUEJQru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:47:50 -0400
Received: from ns.suse.de ([195.135.220.2]:47251 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264862AbUEJQrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:47:48 -0400
Subject: Re: Distributions vs kernel development
From: Chris Mason <mason@suse.com>
To: James Morris <jmorris@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0405101137310.1943-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0405101137310.1943-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1084207748.2583.36.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 12:49:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 11:39, James Morris wrote:
> On Fri, 7 May 2004, Andi Kleen wrote:
> 
> > The reiserfs attribute patch has been submitted many times,
> > but rejected for totally bogus reasons. You know who to complain to.
> 
> I'd really like to see the xattr + SELinux stuff go in, so that SELinux 
> users can have filesystem labeling under Reiserfs.  I'll volunteer to help 
> maintain this part of the code in mainline.

Thanks James.  Andrew wanted to wait until 2.6.7-pre before sending the
reiserfs acl bits to mainline; they have been sent up to Linus now.

-chris


