Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284546AbRLESk4>; Wed, 5 Dec 2001 13:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284543AbRLESkq>; Wed, 5 Dec 2001 13:40:46 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:51211 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S284546AbRLESka>; Wed, 5 Dec 2001 13:40:30 -0500
Date: Wed, 5 Dec 2001 18:40:28 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: smithmg@agere.com, kernelnewbies@nl.linux.org
Subject: Re: Unresolved symbol memset
Message-ID: <20011205184028.A82273@compsoc.man.ac.uk>
In-Reply-To: <009001c17db9$42aa18b0$4d129c87@agere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009001c17db9$42aa18b0$4d129c87@agere.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Hot Toddy - Super Magic
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 01:18:37PM -0500, Michael Smith wrote:

> Hello all,
>      I am new the Linux world and have a problem which is somewhat
> confusing.  I am using the system call memset() in kernel code written
> for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible with
> Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
> This is only happening in one place of the code in one file.  I am using
> memset() in other areas of the code which does not lead to the problem.

You need to compile with optimisation turned on.

Btw, your question would be more appropriate on the kernelnewbies list - see
http://www.kernelnewbies.org/

regards
john

-- 
"Faced with the prospect of rereading this book, I would rather have 
 my brains ripped out by a plastic fork."
	- Charles Cooper on "Business at the Speed of Thought" 
