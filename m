Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318842AbSHET05>; Mon, 5 Aug 2002 15:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318846AbSHET05>; Mon, 5 Aug 2002 15:26:57 -0400
Received: from mail.coastside.net ([207.213.212.6]:14591 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S318842AbSHET05>; Mon, 5 Aug 2002 15:26:57 -0400
Mime-Version: 1.0
Message-Id: <p05111a38b9748258869a@[207.213.214.37]>
In-Reply-To: <3D4ECF2B.2070000@mandrakesoft.com>
References: <200208051906.g75J6d122986@www.hockin.org>
 <3D4ECF2B.2070000@mandrakesoft.com>
Date: Mon, 5 Aug 2002 12:30:22 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: ethtool documentation
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:16 PM -0400 8/5/02, Jeff Garzik wrote:
>Tim Hockin wrote:
>>Is there a document describing the ethtool ioctl's which need to be
>>implemented in each ethernet driver?
>
>Unfortunately not.  There is a distinct lack of network driver docs 
>at the moment...  The best documentation is looking at source code 
>of drivers that implement the most ioctls.

Is there a driver with anything like what you'd consider a canonical 
(or at least exemplary) implementation of the ethtool ioctls?
-- 
/Jonathan Lundell.
