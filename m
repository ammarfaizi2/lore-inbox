Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264451AbRF3AKK>; Fri, 29 Jun 2001 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbRF3AKA>; Fri, 29 Jun 2001 20:10:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15880 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264340AbRF3AJx>; Fri, 29 Jun 2001 20:09:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
Date: Sat, 30 Jun 2001 02:12:11 +0200
X-Mailer: KMail [version 1.2]
Cc: mistral@stev.org, linux-mm@kvack.org, rcastro@ime.usp.br, abali@us.ibm.com,
        riel@conectiva.com.br, phillips@bonn-fries.net, viro@math.psu.edu
In-Reply-To: <200106292040.PAA03583@ccure.karaya.com>
In-Reply-To: <200106292040.PAA03583@ccure.karaya.com>
MIME-Version: 1.0
Message-Id: <01063002121100.10025@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 June 2001 22:40, Jeff Dike wrote:
> The bug was UML-specific and specific in such a way that I don't think it's
> possible to find the bug in the native kernel by making analogies from the
> UML bug.

Heh, too bad, there goes that chance to show uml bagging a major kernel bug.  
But it's just a matter of time...

--
Daniel
