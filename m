Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTFYWUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTFYWUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:20:45 -0400
Received: from cerberus.uk.clara.net ([195.8.69.103]:51213 "EHLO
	cerberus.uk.clara.net") by vger.kernel.org with ESMTP
	id S265111AbTFYWUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:20:44 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Date: Wed, 25 Jun 2003 23:34:53 +0100
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
X-no-productlinks: yes
X-Comment-To: Scott McDermott
References: <fa.hh6ttrp.1d52bhj@ifi.uio.no> <fa.h3c32fv.r5m12l@ifi.uio.no>
Subject: Re: weird postfix mailspool corruption with 2.4.21-ac2+ (was Re: Linux 2.4.21-ac3)
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-15
NNTP-Posting-Host: daria.co.uk
Message-ID: <f65.3efa238d.6e30e@trespassersw.daria.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.h3c32fv.r5m12l@ifi.uio.no>,
	Scott McDermott <vaxerdec@frontiernet.net> writes:
SM> Thijs on Wed 25/06 22:29 +0200:
>> Since 2.4.21-ac2 i'm experiencing problems with Postfix on
>> Debian Stable. Messages get corrupted while being handled
>> by Postfix.
SM> 
SM> I thought I was crazy, I'm seeing this also.  I had to
SM> switch my kernel back on our mail hub because postfix kept
SM> doing this every time I boot the new kernel.  I tried to
SM> figure out why but could not; the system *appears* to run
SM> normally otherwise.  I was moving from 2.4.21-pre4-ac1
SM> +gibbs-aic7xxx patches from that time, to 2.4.21-ac2
SM> +gibbs-aic7xxx from 20030603, and I thought that might be it
SM> (the AIC patches); are you running AIC adapters on your
SM> system with the gibbs patches by any chance?
SM> 

No AIC or any kind here. Bring on the next suspect.


