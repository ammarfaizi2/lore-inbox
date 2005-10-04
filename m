Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVJDTOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVJDTOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVJDTOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:14:49 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:27353 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964934AbVJDTOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUsgG6PANeCbrT+5YlZtyvbcCG4UKPEUfMOIBnKhDwZ/f2Q/rnGNOiIbEuTh11zLQ62UDXVbW6n/xMsGobnC1pkx9ztuhHKCjHKPqdCOS0rzNePsq25rSExfHElBUixIsnPfGwTI89zR4UTam8q0xoZpdmbWP8bwUGd7ew9mM/o=
Message-ID: <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
Date: Tue, 4 Oct 2005 12:14:47 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
In-Reply-To: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm no responses on this thread a couple days now.  I guess:

1) No one cares about private namespaces or the fact that they make
/etc/mtab totally inconsistent.
2) Private Namespaces aren't important to anyone and will never be
robust unless someone who cares, like me, takes it over somehow.
3) Everyone is busy with their own shit and doesn't want to deal with
me or mine right now.

I'm seriously hoping it's 3 :).  2 Is acceptable too of course.  I
think this is important and I want to know more about the innards
anyway.  1 would make me sad as I think Linux can really show other
Unix's what-for here when it comes to showing off how good the VFS can
be.

Linux has always been a bit of DIY, so I guess I just need to accept
that.  It's not unlike the KDE development model.  People who want
certain things done either motivate others to help or make a run for
it on their own, even in the face of adversity.  Kind of more noble
that way I guess.

Dave
