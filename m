Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUHQVtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUHQVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268471AbUHQVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:49:16 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:40102 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S268470AbUHQVtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:49:14 -0400
From: Markus Walser <walsi@freesurf.ch>
To: Dragan Stancevic <visitor@xalien.org>, linux-kernel@vger.kernel.org
Subject: Re: Terrible Memory leak on 2.6
Date: Tue, 17 Aug 2004 23:49:11 +0200
User-Agent: KMail/1.5.1
References: <200408150051.34157.visitor@xalien.org>
In-Reply-To: <200408150051.34157.visitor@xalien.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408172349.11738.walsi@freesurf.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, same problem here. And on the SuSE mailing list many other reported the
same when burning audio CDRs. I could reproduce it with vanilla-2.6.8-rc3/
2.6.8-rc4 too. Up to now I was just reading about problems with IDE drives.

Best regards, 

Markus


Am Sonntag 15 August 2004 09:51 schrieb Dragan Stancevic:
> Hi-
>
> has anyone else by any chance seen a memory leak during ripping of CDs
> or writing CDs. On my system SuSE 9.1 "2.6.5-7.104-default" I can only,
> rip or burn one CD. The system runs out of memory and hangs about
> half way through the second cd.
>
> I tried just creating the image but not writing and than doesn't seem to
> cause the problem. Only when the CD burner is used I see this problem.
>
> The burner is an Emprex DVDRW 1008IM, used on an Athlon XP 2500+
> system with 1GB of ram and 1GB of swap. The system seems to lock up
> when all the ram is exhausted, the swap is about 90% free.
>
> I haven't debugged the problem much I just wanted to ask around before
> I start digging in.
>
> Thanks.

