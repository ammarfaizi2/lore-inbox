Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280930AbRKTGEI>; Tue, 20 Nov 2001 01:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280931AbRKTGDs>; Tue, 20 Nov 2001 01:03:48 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:2203 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280930AbRKTGDm>;
	Tue, 20 Nov 2001 01:03:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Curt McCutchin <sitruc@mailandnews.com>
Subject: Re: Another wonderful OOPS!
Date: Mon, 19 Nov 2001 22:03:08 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011119224528.3fae4411.sitruc@mailandnews.com>
In-Reply-To: <20011119224528.3fae4411.sitruc@mailandnews.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1663zw-0001ek-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 20:45, Curt McCutchin wrote:
> I hope this is helpful this time.
> system stats in case they matter:
>
> hardwarewise:
> -------------
...
> -hercules geforce 2 mx 32mb video card
...
> softwarewise:
> -------------
...
> -NVidia 1.0-1541 driver
...
>  Nov 19 21:10:42 snotball kernel: Process XFree86 (pid: 220, 
stackpage=d58f7000)
....

You're going to recieve very little help from this list for debugging an 
XFree86 crash using a binary-only driver. Although this sort of driver are 
almost always the source of XFree86 problems, I'm sure this list would be 
more than happy to help if you are able to reproduce the problem using 
official, open source Linux drivers.

-Ruan
