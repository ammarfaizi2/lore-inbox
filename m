Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTEMSDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEMSCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:02:11 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.93.67.84]:11408 "EHLO
	ms-smtp-03.southeast.rr.com") by vger.kernel.org with ESMTP
	id S263372AbTEMR7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:59:55 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Tue, 13 May 2003 14:17:11 -0400
User-Agent: KMail/1.5.1
References: <3EBC9C62.5010507@nortelnetworks.com> <200305120717.07468.techstuff@gmx.net> <200305131158.h4DBw2u30860@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200305131158.h4DBw2u30860@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305131417.11361.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 13 2003 8:04 am, Denis Vlasenko wrote:
> On 12 May 2003 14:17, Boris Kurktchiev wrote:
> > I forgot to add that if I leave the machine long enough on (2-3 days)
> > the RAM usage goes down to like the normal 5/6% BUT the swap is
> > totaly used up with maybe like 5/6% left free.
> > Also, I forgot to attach my kernel config in case it helped,, so here
> > it is
>
> Instead of describing your problem at length just show top
> and various cat /proc/* output
> --
> vda

oh yeah and also if I turn swap off and leave the machine one besides the fact 
that RAM usage does not go below 50% apps start dying from OOM (out of 
memory) problems (even if there is more RAM free).

