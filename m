Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130953AbRA2Jn6>; Mon, 29 Jan 2001 04:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRA2Jnr>; Mon, 29 Jan 2001 04:43:47 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:36622 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130953AbRA2Jnl>; Mon, 29 Jan 2001 04:43:41 -0500
Message-ID: <3A753B1B.579D09A3@idb.hist.no>
Date: Mon, 29 Jan 2001 10:42:51 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: "Randal, Phil" <prandal@herefordshire.gov.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <AFE36742FF57D411862500508BDE8DD055F6@mail.herefordshire.gov.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randal, Phil" wrote:
> 
> James Sutherland wrote:
> 
> > Except you can't retry without ECN, because DaveM wants to do
> > a Microsoft and force ECN on everyone, whether they like it
> > or not. If ECN is so wonderful, why doesn't anybody actually
> > WANT to use it anyway?
> 
> And there's the rub.  Whether ECN is wonderful or not, attempting
> to force it on everyone, whether they like it or not, whether
> (for whatever reason) they are able to upgrade their firewalls
> to handle ECN appropriately or not, is a recipe for a "Great
> Linux Public Relations Disaster".
> 
> Because if we do try to force it, the response which will come
> back won't be "Linux is wonderful, it conforms to the standards".
> It will be "Linux sucks, we can't connect to xyz.com with it (or
> we can't connect because to xyz.com they run it)".
> 
> We may be right, "they" may be wrong, but in the real world
> arrogance rarely wins anyone friends.

This problem doesn't exist, because linux users don't need to
use ECN if they don't want to.  It is optional!  Those who
*care* about hotmail etc. can turn it off!  The only ones who get
ECN turned on is those who compile their own kernels.  They
have the skill to turn it off if they need.  The
distributions don't ship kernels with ECN default on.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
