Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVAGVqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVAGVqC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVAGVqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:46:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:6554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261622AbVAGVpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:45:45 -0500
Date: Fri, 7 Jan 2005 13:49:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: paul@linuxaudiosystems.com, arjanv@redhat.com, hch@infradead.org,
       mingo@elte.hu, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, joq@io.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050107134941.11cecbfc.akpm@osdl.org>
In-Reply-To: <1105132348.20278.88.camel@krustophenia.net>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Really, I think Linux has owned the server space for so long that some
> folks on this list are getting hubristic.  Just because you have the
> best server OS does not mean it's the best at everything.

nah, the requirement is clearly valid, and longstanding.  We need to
satisfy it.  It's just a matter of working out the best way.

Chris Wright <chrisw@osdl.org> wrote:
>
> ...
> Last I checked they could be controlled separately in that module.  It
> has been suggested (by me and others) that one possible solution would
> be to expand it to be generic for all caps.

Maybe this is the way?
