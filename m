Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbRACPQl>; Wed, 3 Jan 2001 10:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132081AbRACPQV>; Wed, 3 Jan 2001 10:16:21 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24593 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S129572AbRACPQP>; Wed, 3 Jan 2001 10:16:15 -0500
Date: Wed, 3 Jan 2001 15:45:48 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.24 is available
Message-ID: <20010103154548.B12561@krusty.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010103124005.A5179@emma1.emma.line.org> <13828.978523385@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <13828.978523385@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Jan 03, 2001 at 23:03:05 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2001, Keith Owens wrote:

> >I can send in a patch if you want (that just changes the docs, but not
> >the functionality).
> 
> Don't bother.  It will change in 2.5 anyway, I can live with the odd
> query until then.  If you really want to get only the version number
> then this will work for modutils 2.x for x >= 3.
> 
>   (/sbin/depmod -V -n | head -1) 2>/dev/null

I was just thinking to write -V "output version in addition to normal
operation" in --help, nothing bigger than like 5 minutes.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
