Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317857AbSGRKnM>; Thu, 18 Jul 2002 06:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317889AbSGRKnL>; Thu, 18 Jul 2002 06:43:11 -0400
Received: from holomorphy.com ([66.224.33.161]:42122 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317857AbSGRKnL>;
	Thu, 18 Jul 2002 06:43:11 -0400
Date: Thu, 18 Jul 2002 03:46:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718104604.GQ1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tobias Rittweiler <inkognito.anonym@uni.de>,
	linux-kernel@vger.kernel.org
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk> <20020718010617.GL1096@holomorphy.com> <1251977776.20020718114800@uni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1251977776.20020718114800@uni.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thursday, July 18, 2002, 3:06:17 AM, you wrote:
>> Could you reproduce this and get maybe a backtrace and a line number?

On Thu, Jul 18, 2002 at 11:48:00AM +0200, Tobias Rittweiler wrote:
> I just want to say that I do get a similiar panic (i hope it's the
> same reason and I do not mix up something), the story about the
> trouble which 2.5.26 is causing I will expound below:
> 
> -snip-
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c025a9d7

Please, decode your oopses.


Cheers,
Bill
