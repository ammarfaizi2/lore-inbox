Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285087AbRLUUA4>; Fri, 21 Dec 2001 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285088AbRLUUAo>; Fri, 21 Dec 2001 15:00:44 -0500
Received: from svr3.applink.net ([206.50.88.3]:32271 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S285087AbRLUUAZ>;
	Fri, 21 Dec 2001 15:00:25 -0500
Message-Id: <200112212000.fBLK0GSr021423@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: timothy.covell@ashavan.org, esr@thyrsus.com
Subject: Re: Configure.help editorial policy (H20 and K2B)
Date: Fri, 21 Dec 2001 13:56:31 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <20011220185226.A25080@thyrsus.com> <200112211305.fBLD5WSr019374@svr3.applink.net>
In-Reply-To: <200112211305.fBLD5WSr019374@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 07:01, Timothy Covell wrote:
> On Thursday 20 December 2001 17:52, Eric S. Raymond wrote:
> > David Garfield <garfield@irving.iisd.sra.com>:
> > > Another option: maybe the choice of KB vs KiB vs KKB should be a
> > > configuration choice.
>
> Um, you know, all due repect to Knuth, the God, I think that
> someof his ideas are downright silly.   Now, my suggestion
> is different, namely, inserting a 2 in the unit such as "K2B"
> meaning Kilo (base2) Byte.    It's not like we don't have a
> precendent from the chemistry and physics fields.

I've changed my mind.   K2B would seem to imply
2**3 Bytes, which is 8 Bytes.  

I think that way to solve the issue is to just byte 
the bullet and stop equating 1024 with K.   It's
just such an inconsistant and ad hoc hack.

The only truly logical way to do this would be
to base everything on bits and powers of
two.  But, since we run out of common prefixes
at 2**6 (exa), we should just stick to decimal
and scientific format.    1024 = 2**10.





-- 
timothy.covell@ashavan.org.
