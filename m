Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130725AbRBLWFO>; Mon, 12 Feb 2001 17:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131552AbRBLWFE>; Mon, 12 Feb 2001 17:05:04 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:34246 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131498AbRBLWEu>; Mon, 12 Feb 2001 17:04:50 -0500
Message-ID: <3A885DFF.824AC093@inet.com>
Date: Mon, 12 Feb 2001 16:04:47 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
CC: matti.aarnio@zmailer.org, linux-kernel@vger.kernel.org
Subject: Re: lkml subject line
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org> <7vh2Hebmw-B@khms.westfalen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Henningsen wrote:
> 
> matti.aarnio@zmailer.org (Matti Aarnio)  wrote on 12.02.01 in <20010212133324.B15688@mea-ext.zmailer.org>:
> 
> > On Mon, Feb 12, 2001 at 11:20:40AM +0000, Guennadi Liakhovetski wrote:
> > > Dear all (and list maintainers in particular)
> > >
> > > Wouldn't it be a good idea to prepend all lkml subjects with [LKML] like
> > > many other lists do to distinguish lkml messages from the rest.
> >
> >   NO!
> 
> Indeed. What a bad idea that would be.
> 
> >   If you want to pre-filter messages traveling thru  linux-kernel  list,
> >   all you need to do is to check the content of   Return-Path:  header.
> 
> On the other hand, that's also not a very good scheme. There *is* a good
> way to do this, and it would be really nice if vger could be taught to do
> it: add a List-Id: header (draft-chandhok-listid-04.txt RFC-to-be,
> implemented in lots of mailing list managers already).

Have you looked at the headers in an LK email?

Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List:         linux-kernel@vger.kernel.org
^^^^^^^^^^^^^^ Should provide that List-Id you want.

Eli
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
