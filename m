Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJMVEw>; Sun, 13 Oct 2002 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJMVEw>; Sun, 13 Oct 2002 17:04:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15238 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261627AbSJMVEu>; Sun, 13 Oct 2002 17:04:50 -0400
Date: Sun, 13 Oct 2002 14:06:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <48100000.1034543175@flay>
In-Reply-To: <20021013205933.GA24140@kroah.com>
References: <39770000.1034541701@flay> <20021013205933.GA24140@kroah.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I will invest some serious effort and time in cleanup after the feature freeze,
>> including investigating using the subarch support which I know some people
>> would like to see done.
> 
> Any reason why most of these changes couldn't be moved to the subarch
> code now?

1. Time
2. It'd make the patches much bigger and harder to read.

I *will* do that. Just not in time for the freeze. IMHO, that's a cleanup (and yes,
a needed one).

M.

