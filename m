Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284570AbRLES7Q>; Wed, 5 Dec 2001 13:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284574AbRLES7G>; Wed, 5 Dec 2001 13:59:06 -0500
Received: from alageremail2.agere.com ([192.19.192.110]:34014 "EHLO
	alageremail2.agere.com") by vger.kernel.org with ESMTP
	id <S284575AbRLES6y>; Wed, 5 Dec 2001 13:58:54 -0500
From: "Michael Smith" <smithmg@agere.com>
To: "'John Levon'" <movement@marcelothewonderpenguin.com>,
        <linux-kernel@vger.kernel.org>
Cc: <kernelnewbies@nl.linux.org>
Subject: RE: Unresolved symbol memset
Date: Wed, 5 Dec 2001 13:59:00 -0500
Organization: Agere Systems
Message-ID: <00a601c17dbe$e6b6ea50$4d129c87@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20011205184028.A82273@compsoc.man.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have optimization turned.  Using -02 in the makefile.

I am new to the linux kernel but not kernel development.  If you still
think this is the wrong list, I will post on the other one.  Sorry if it
is the wrong list


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John Levon
Sent: Wednesday, December 05, 2001 1:40 PM
To: linux-kernel@vger.kernel.org
Cc: smithmg@agere.com; kernelnewbies@nl.linux.org
Subject: Re: Unresolved symbol memset

On Wed, Dec 05, 2001 at 01:18:37PM -0500, Michael Smith wrote:

> Hello all,
>      I am new the Linux world and have a problem which is somewhat
> confusing.  I am using the system call memset() in kernel code written
> for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible
with
> Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
> This is only happening in one place of the code in one file.  I am
using
> memset() in other areas of the code which does not lead to the
problem.

You need to compile with optimisation turned on.

Btw, your question would be more appropriate on the kernelnewbies list -
see
http://www.kernelnewbies.org/

regards
john

-- 
"Faced with the prospect of rereading this book, I would rather have 
 my brains ripped out by a plastic fork."
	- Charles Cooper on "Business at the Speed of Thought" 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

