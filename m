Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268595AbRHHTb4>; Wed, 8 Aug 2001 15:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRHHTbq>; Wed, 8 Aug 2001 15:31:46 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:13074 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S268595AbRHHTbi>;
	Wed, 8 Aug 2001 15:31:38 -0400
Date: Wed, 8 Aug 2001 13:27:55 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Hubertus Franke <frankeh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010808132755.A8255@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010808112800.F1088@w-mikek2.des.beaverton.ibm.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 11:28:00AM -0700, Mike Kravetz wrote:
> One challenge will be maintaining the same level of performance
> for UP as in the current code.  The current code has #ifdefs to

How does the "current code" compare to the current Linux UP code?


