Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRIZPtd>; Wed, 26 Sep 2001 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275283AbRIZPtY>; Wed, 26 Sep 2001 11:49:24 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:22537 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S275278AbRIZPtK>; Wed, 26 Sep 2001 11:49:10 -0400
Date: Wed, 26 Sep 2001 08:49:34 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Robert Love <rml@ufl.edu>
cc: David Wagner <daw@mozart.cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
In-Reply-To: <1001465531.10701.61.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109260846490.28241-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Sep 2001, Robert Love wrote:

> Some diskless machines really have _zero_ entropy.

have you considered the Network Randomization Protocol?

http://www.usenix.org/publications/library/proceedings/security95/full_papers/chow.txt

-dean

