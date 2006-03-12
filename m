Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWCLDfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWCLDfM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWCLDfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:35:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41948 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751285AbWCLDfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:35:10 -0500
Subject: Re: Linux v2.6.16-rc6
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060312032840.GA1165818@hiwaay.net>
References: <fa.B/Q39e5tdKA8fofqhtAW7OLh/1U@ifi.uio.no>
	 <20060312032840.GA1165818@hiwaay.net>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 22:35:04 -0500
Message-Id: <1142134505.25358.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 21:28 -0600, Chris Adams wrote:
> Once upon a time, David S. Miller <davem@davemloft.net> said:
> >> TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> >> 148470938:148470943. Repaired.
> >
> >It is a problem with the remote TCP implementation, it is
> >illegally advertising a smaller window that it previously
> >did.
> 
> Is this something that should be logged though?  I get these messages
> all the time on my mirror server.  It isn't like I can do anything about
> it.  If Linux is generous in what it accepts and can handle it, what is
> the logged error for?

I have been seeing these since the 2.4 era (possibly 2.2).

Unless this is something that just started with 2.6.15-rc6 then it's OT
for this thread.

Lee

