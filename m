Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWETAnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWETAnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWETAnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:43:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:56181 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWETAnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:43:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=m+sc4AegTrgEkQ1zxuhAs0mKp4pVeYTfWuRreUwkZc73bwb5IOrTqMaI5jZqIIFiKUpIl0ay1DwSwpQbwgIy51nnVb+QD/gn7fycKdFTJxkCUgiyBYjn9hhVG2rbGoIuw7QShHkUxixbqJUnlc3hPf1TEDipgd81CIANRmZ/4NA=
Message-ID: <446E6642.8030706@gmail.com>
Date: Fri, 19 May 2006 17:43:46 -0700
From: Jeff Carr <basilarchia@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: linux cbon <linuxcbon@yahoo.fr>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, David Greaves <david@dgreaves.com>
Subject: Re: replacing X Window System !
References: <20060519151351.39838.qmail@web26608.mail.ukl.yahoo.com> <1148051890.26628.138.camel@capoeira>
In-Reply-To: <1148051890.26628.138.camel@capoeira>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/06 08:18, Xavier Bestel wrote:

>>> See DRI homepage for more information.

That page should be wiki'fied as it doesn't seem to be keeping pace with
the improvements in X.

>> How does DRI compare with other drivers ?
> 
> DRI is not finished for r300 cards (radeon 9600 => X700 IIRC), but it
> kind of works.

3D acceleration is working well on my portable's ATI Technologies Inc
RV350 [Mobility Radeon 9600 M10]. ppracer runs well. Lots of
improvements have been made with xorg; a trend I'm sure everyone would
like to see continue.

X Window System Version 7.0.0
Release Date: 21 December 2005
X Protocol Version 11, Revision 0, Release 7.0
Build Operating System:Linux 2.6.12-1-686 i686
Current Operating System: Linux jcarr 2.6.17-rc2-g6b426e78 #3 SMP Mon
Apr 24 15:46:38 PDT 2006 i686
Build Date: 16 March 2006

