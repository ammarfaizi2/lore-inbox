Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUKON3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUKON3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUKON3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:29:32 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:8842 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261591AbUKON3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:29:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LLZ+arym7/OzyxuJFpVkvv4+ZqQenPLtLWDU60y1r98Jn+6tkaCtu74UAvAJOTTQCy8CSWNeVLZFLGjlGhL5b40/z6DSX62wxhIWq+B2omUZe9yntvgDT5DPIge2b3XswUiye9XRt5lCMHSO2/2lyWBuxr9di3RsxcR8ahmaIWk=
Message-ID: <4d8e3fd304111505296c17d6c3@mail.gmail.com>
Date: Mon, 15 Nov 2004 14:29:29 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Stephan Menzel <stephan42@chinguarime.net>
Subject: Re: [FS] New monitor framework in 2.6.10?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411151344.50668.stephan42@chinguarime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411151113.06386.stephan42@chinguarime.net>
	 <Pine.LNX.4.53.0411151121240.6893@yvahk01.tjqt.qr>
	 <200411151142.33640.stephan42@chinguarime.net>
	 <200411151344.50668.stephan42@chinguarime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004 13:44:50 +0100, Stephan Menzel
<stephan42@chinguarime.net> wrote:
> Am Montag, 15. November 2004 11:42 schrieb Stephan Menzel:
> > > Wasnot it called System Call Auditing and/or Filesystem hooks?
> >
> > Well, that's what I'd like to know.
> 
> And I just found an answer:
> 
> inotify. http://lwn.net/Articles/104312/
> That looks fine to me.
> What happened to this? It's not in the vanilla 2.6.9 as far as I can see. Will
> it be in 2.6.10?

Yes, it's already in the -bk snapshot.

-- 
Paolo
Personal home page: www.ciarrocchi.tk
Picasa users groups: www.picasa-users.tk
join the blog group: http://groups-beta.google.com/group/blog-users
