Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291963AbSBNWjk>; Thu, 14 Feb 2002 17:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291965AbSBNWjb>; Thu, 14 Feb 2002 17:39:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:34253 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291963AbSBNWjT>; Thu, 14 Feb 2002 17:39:19 -0500
Date: Thu, 14 Feb 2002 14:39:50 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: viro@math.psu.edu, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk
Message-ID: <10970000.1013726390@w-hlinder.des>
In-Reply-To: <Pine.LNX.4.33.0202141153300.24637-100000@serv>
In-Reply-To: <Pine.LNX.4.33.0202141153300.24637-100000@serv>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 14, 2002 12:13:38 +0100 Roman Zippel <zippel@linux-m68k.org> wrote:

> Could you please configure your editor to use tabs instead of spaces?
> It would make the patch smaller and easier to read.

	That happens when I cut and paste. I will make sure to fix it 
	when I submit the patch.

> IMO it would be better to use a count, which limits to number of lookups
> done with the spinlock held. 

	Thanks for taking a look at the patch and giving me your
	input. I will need to think about your suggestions.

Take Care,

Hanna

