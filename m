Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRCSIHQ>; Mon, 19 Mar 2001 03:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbRCSIHG>; Mon, 19 Mar 2001 03:07:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131386AbRCSIGw>;
	Mon, 19 Mar 2001 03:06:52 -0500
Date: Mon, 19 Mar 2001 07:37:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: kuznet@ms2.inr.ac.ru
Cc: Eugene Crosser <crosser@average.ORG>, linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
Message-ID: <20010319073703.B16622@flint.arm.linux.org.uk>
In-Reply-To: <97hbjr$mbp$1@pccross.average.org> <200102282020.XAA05430@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102282020.XAA05430@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Feb 28, 2001 at 11:20:22PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 11:20:22PM +0300, kuznet@ms2.inr.ac.ru wrote:
> I remember this your report. However, recent news force to suspect
> that the reason was in Solaris yet. Actually, if you send tcpdump of
> failed session, this question can be answered.

Well, since I moved the rsync to 5pm, and then back to 9pm, I haven't
seen this problem - everything is again working as expected (touch wood)
with 2.2.15pre13 and 2.4.0.

This is odd, since it wasn't a one-off problem, but something that happened
each and every day of a particular week.  Anyway, if it starts happening
again, I'll get a tcpdump of the session.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

