Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRLRQNG>; Tue, 18 Dec 2001 11:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284156AbRLRQM5>; Tue, 18 Dec 2001 11:12:57 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:1043 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S284141AbRLRQMv>;
	Tue, 18 Dec 2001 11:12:51 -0500
Date: Tue, 18 Dec 2001 09:06:06 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <20011218090606.A4786@hq2>
In-Reply-To: <20011217083802.A25219@hq2> <Pine.LNX.4.33.0112181753230.3753-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112181753230.3753-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 05:55:14PM +0100, Ingo Molnar wrote:
> 
> On Mon, 17 Dec 2001, Victor Yodaiken wrote:
> 
> > I agree with all your arguments up to here. But being able to run
> > Linux in 4Meg or even 8M is important to a very large class of
> > applications. [...]
> 
> the amount of reserved RAM should be very low. Especially in embedded
> applications that usually have a very controlled environment, with a low
> number of well-behaving devices, the number of pages needed to be reserved
> is very low. I wouldnt worry about this.


Bueno.
