Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTEHEVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 00:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTEHEVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 00:21:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261166AbTEHEVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 00:21:39 -0400
Message-ID: <32847.4.64.196.31.1052368454.squirrel@www.osdl.org>
Date: Wed, 7 May 2003 21:34:14 -0700 (PDT)
Subject: Re: garbled oopsen
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <akpm@digeo.com>
In-Reply-To: <20030507184054.684e2bd0.akpm@digeo.com>
References: <20030507180530.23d0e780.rddunlap@osdl.org>
        <20030507184054.684e2bd0.akpm@digeo.com>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>>
>> I have several oopses that are garbled.
>
> Use kgdb.
>
>> Can these be cleaned up in any reasonable way?
>
> It needs some additional spinlock in there.  People have moaned for over a
> year, patches have been floating about but nobody has taken the time to
> finish one off and submit it.
>
> It's never bothered me, because availability of a serial console equates to
> availability of kgdb.

I'm more interested in having it clean for people who use 2.6.x.
Yes, I can get by without it or by using kgdb, but that's not the point IMO.

~Randy



