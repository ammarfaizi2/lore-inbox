Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRLDDnk>; Mon, 3 Dec 2001 22:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283167AbRLCXqQ>; Mon, 3 Dec 2001 18:46:16 -0500
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:38274 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S284419AbRLCKjl>; Mon, 3 Dec 2001 05:39:41 -0500
Date: Mon, 3 Dec 2001 10:38:40 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] JBD code path (kfree cleanup)
Message-ID: <20011203103840.A2857@redhat.com>
In-Reply-To: <20011201160839.A2773@redhat.com> <Pine.LNX.4.33.0112011817370.12820-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112011817370.12820-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Sat, Dec 01, 2001 at 06:24:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 06:24:12PM +0200, Zwane Mwaikambo wrote:
> Thanks i'll remove that bit out, i wasn't entirely sure as i'm not that
> familiar with that bit of code.

Yep, but when you are making purely cosmetic changes to code you don't
know well, you really have to be careful not to change the logic at
all.

Cheers,
 Stephen
