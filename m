Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUD1VBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUD1VBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUD1T5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:57:36 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:45292 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S264973AbUD1RFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:05:48 -0400
From: Goran Cengic <cengic@s2.chalmers.se>
Organization: Chalmers University of Technology
To: linux-kernel@vger.kernel.org
Subject: Re: Special place for tird-party modules.
Date: Wed, 28 Apr 2004 19:05:45 +0200
User-Agent: KMail/1.6
References: <200404281814.24991.cengic@s2.chalmers.se> <200404281835.24836.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404281835.24836.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404281905.45373.cengic@s2.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 18.35, Bartlomiej Zolnierkiewicz wrote:
> Hey, we already have a special place for binary only modules.
>
> It is called /dev/null. 8)

:)

>
> > against this approach? Why does the nvidia driver have to be compiled for
> > different kernel versions? Can't they make one module that fits all
> > kernels?
>
> No, it was discussed zillion times already.

Where can I find the discussion? Was it on this list?

>
> > If I'm missing something cruical please point it out to me.
>
> You are missing fact that module compiled for specific kernel version
> may not work with another kernel version. ;-)

Ok, but why is there possibility to ignore version number of the modules if it 
makes no sense?

>
> Cheers,
> Bartlomiej

/Goran

Goran Cengic
mailto:cengic@s2.chalmers.se
------------------------------
Have a nice day :)
