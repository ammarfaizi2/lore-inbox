Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTDWVmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTDWVmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:42:06 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:33958 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264252AbTDWVmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:42:05 -0400
Subject: Re: 2.5.68 kernel no initrd
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: =?iso-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
Cc: Dave Mehler <dmehler26@woh.rr.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl>
References: <000701c306f6$cf100180$0200a8c0@satellite>
	 <1050859494.595.4.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-2
Organization: 
Message-Id: <1051134842.652.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 23 Apr 2003 23:54:02 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 15:49, Pawe³ Go³aszewski wrote:
> initrd gives much more flexibility.
> I can make one kernel and use it on _all_ of my mashines, just change 
> initrd. quick, nice and flexible with proper initrd tools set.

I don't have any doubts that initrd is a very flexible solution and
provides for a generic kernel. However, in the end (I'm talking about my
experiences), initrd has caused me more troubles than problems it
solved. I always keep all "config" file for every kernel I use on my
machines.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

