Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTIJOgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264831AbTIJOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:36:00 -0400
Received: from hal-4.inet.it ([213.92.5.23]:26097 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S264829AbTIJOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:35:58 -0400
Message-ID: <057301c377a9$59ad16c0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Stewart Smith" <stewart@linux.org.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <1063203673.7631.35.camel@willster>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 16:39:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hrm, you may find things related to the Password-Capability system and
> the Walnut kernel of interest - these systems take this kind of IPC to
> the extreme :) (ahhh... research OS hw & sw - except you *do not* want
> to see the walnut source - it makes ppl want to crawl up and cry).
> 
> http://www.csse.monash.edu.au/~rdp/fetch/castro-thesis.ps
> 
> and check the Readme.txt at
> http://www.csse.monash.edu.au/courseware/cse4333/rdp-ma terial/
> for stuff on Multi and password-capabilities.
> 
> interesting stuff, the Castro thesis does do some comparisons to FreeBSD
> (1.1 amazingly enough) - although the number of real world applications
> on these systems is minimal (and in the current state impossible -
> nobody can remember how to get userspace going on Walnut, we may have
> broken it) and so real-world comparisons just don't really happen these
> days. Maybe after a rewrite (removing some brain-damage of the original
> design).

Thanks. It's really very interesting...

Bye,
Luca
