Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131642AbRCSXJT>; Mon, 19 Mar 2001 18:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131652AbRCSXJL>; Mon, 19 Mar 2001 18:09:11 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:49418 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131642AbRCSXI4>;
	Mon, 19 Mar 2001 18:08:56 -0500
Date: Tue, 20 Mar 2001 00:07:38 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
Message-ID: <20010320000738.E19635@almesberger.net>
In-Reply-To: <3AB66233.B85881C7@bluewin.ch> <Pine.LNX.3.95.1010319150027.9639A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010319150027.9639A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Mar 19, 2001 at 03:15:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Unix and other such variants have what's called a Virtual File System
> (VFS).

Correct, but hardly relevant here, except possibly that this enables you
to use a different, perhaps more resilient file system.

> The idea behind this is to keep as much recently-used file stuff
> in memory so that the system can be as fast as if you used a RAM disk
> instead of real physical (slow) hard disks.

Correct, but does not require VFS.

Nice try, though.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
