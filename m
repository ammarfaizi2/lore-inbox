Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRAZVWD>; Fri, 26 Jan 2001 16:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130855AbRAZVVn>; Fri, 26 Jan 2001 16:21:43 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:59751 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130670AbRAZVVh>; Fri, 26 Jan 2001 16:21:37 -0500
Message-ID: <3A71EA53.3B2F39B@linux.com>
Date: Fri, 26 Jan 2001 21:21:23 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randal, Phil" <prandal@herefordshire.gov.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <AFE36742FF57D411862500508BDE8DD055F6@mail.herefordshire.gov.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randal, Phil" wrote:

> James Sutherland wrote:
>
> > Except you can't retry without ECN, because DaveM wants to do
> > a Microsoft and force ECN on everyone, whether they like it
> > or not. If ECN is so wonderful, why doesn't anybody actually
> > WANT to use it anyway?
>
> And there's the rub.  Whether ECN is wonderful or not, attempting
> to force it on everyone, whether they like it or not, whether
> (for whatever reason) they are able to upgrade their firewalls
> to handle ECN appropriately or not, is a recipe for a "Great
> Linux Public Relations Disaster".

Nobody is forcing you to use ECN, it is a compile time AND runtime option.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
