Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274190AbRIXWAH>; Mon, 24 Sep 2001 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274188AbRIXWAB>; Mon, 24 Sep 2001 18:00:01 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:30266 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274165AbRIXV7V>; Mon, 24 Sep 2001 17:59:21 -0400
Subject: Re: report: success with agp_try_unsupported=1
From: Robert Love <rml@ufl.edu>
To: Peter Jay Salzman <p@dirac.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1001368244.1194.27.camel@phantasy>
In-Reply-To: <20010924144006.A13695@dirac.org> 
	<1001368244.1194.27.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 24 Sep 2001 17:59:46 -0400
Message-Id: <1001368787.8773.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-24 at 17:50, Robert Love wrote:
> I will write a patch for this to add VIA KT266 support (so you don't
> need to do the agp_try_unsupported=1 mess, it will be supported
> natively).  Although, the patch is going to be against 2.4.10.

I take that back, no I won't :)

I think support was added during 2.4.10-pre from a merge with Alan's
tree.

Upgrade to 2.4.10 and see if not it works.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

