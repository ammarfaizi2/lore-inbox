Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVEMS42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVEMS42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVEMSyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:54:21 -0400
Received: from smtpout01-04.mesa1.secureserver.net ([64.202.165.79]:35781 "HELO
	smtpout01-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S262488AbVEMSt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:49:27 -0400
Message-ID: <4284F6B5.2080308@coyotegulch.com>
Date: Fri, 13 May 2005 14:49:25 -0400
From: Scott Robert Ladd <lkml@coyotegulch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@muc.de>, Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-Threading Vulnerability
References: <1115963481.1723.3.camel@alderaan.trey.hu>	 <m164xnatpt.fsf@muc.de> <1116009347.1448.489.camel@localhost.localdomain>
In-Reply-To: <1116009347.1448.489.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> HT for most users is pretty irrelevant, its a neat idea but the
> benchmarks don't suggest its too big a hit

On real-world applications, I haven't seen HT boost performance by more
than 15% on a Pentium 4 -- and the usual gain is around 5%, if anything
at all. HT is a nice idea, but I don't enable it on my systems.

..Scott
