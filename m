Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319651AbSH3TBB>; Fri, 30 Aug 2002 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319652AbSH3TBA>; Fri, 30 Aug 2002 15:01:00 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49668 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319651AbSH3TBA>; Fri, 30 Aug 2002 15:01:00 -0400
Message-ID: <3D6FC178.CC3E89CD@zip.com.au>
Date: Fri, 30 Aug 2002 12:03:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jani Monoses <jani@iv.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
References: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Monoses wrote:
> 
> This turns the remaining parts of ext3 to EXT3_SB and turns the latter
> from a macro to inline function which returns the generic_sbp field of u.

Thanks.

It's not going to make the merge of all Stephen's 2.4 changes
any more fun though ;)
