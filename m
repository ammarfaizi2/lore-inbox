Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSKOBij>; Thu, 14 Nov 2002 20:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKOBij>; Thu, 14 Nov 2002 20:38:39 -0500
Received: from rth.ninka.net ([216.101.162.244]:52370 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265457AbSKOBij>;
	Thu, 14 Nov 2002 20:38:39 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1037313872.1597.11.camel@rousalka>
References: <1037313872.1597.11.camel@rousalka>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 18:03:59 -0800
Message-Id: <1037325839.13735.4.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While I have this on my mind I want to express this now since the
very first bug that hit my mailbox had this issue.

I DO NOT want to be working on bugs on anything other than Linus's
actualy sources.  The first bug I got was a networking bug with
Andrew Morton's -mm patches applied.

This isn't going to work if that is what people are going to be
allowed to do.

I want to suggest that all reported bug in the database must be
reporducable with some release done by Linus or his BK sources.
And also that we can automatically close any BUG submissions that
have other patches applied.

