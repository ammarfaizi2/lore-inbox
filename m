Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280477AbRJaUiA>; Wed, 31 Oct 2001 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280485AbRJaUhu>; Wed, 31 Oct 2001 15:37:50 -0500
Received: from dsl-213-023-038-229.arcor-ip.net ([213.23.38.229]:30724 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S280477AbRJaUhc>;
	Wed, 31 Oct 2001 15:37:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Wed, 31 Oct 2001 21:39:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15z28m-0000vb-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> I just tried your test program with 2.4.13, 2 Gig, and it ran without 
> problems.  Could you try that over there and see if you get the same result?
> If it does run, the next move would be to check with 3.5 Gig.

Ben reports that his test with 2 Gig memory runs fine, as it does for me, but 
that it locks up tight with 3.5 Gig, requiring power cycle.  Since I only 
have 2 Gig here I can't reproduce that (yet).

--
Daniel
