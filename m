Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUG3HWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUG3HWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUG3HVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 03:21:17 -0400
Received: from guardian.hermes.si ([193.77.5.150]:59653 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S267655AbUG3HSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 03:18:22 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090209@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: "'David Burg'" <dburg@nero.com>, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: RE: Can not read UDF CD
Date: Fri, 30 Jul 2004 09:17:51 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How should I make the image ?
Remember, it is a multisession CD ( has two sessions ).

> ----------
> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> Sent: 	29. julij 2004 19:06
> To: 	David Balazic
> Cc: 	'David Burg'; linux_udf@hpesjro.fc.hp.com;
> linux-kernel@vger.kernel.org
> Subject: 	Re: Can not read UDF CD
> 
> // David Balazic:
> 
> > I will try to see if the problem is reproducable with burning
> > more UDF CDs...
> 
> Yes please thank you.
> 
> >> I attach the "udf_test -scsi 1:0" output.
> 
> Attach did Not arrive here, sorry, please retry attach, at least to me, 
> else publish on web.
> 
> Also please say if you can easily share a .iso image of the disc.  (Of 
> course I imagine linux_udf and linux-kernel don't want that attached.)
> 
> >> -	   Main: length,location: 32768, 30654 expected:  32768, 32
> >> -	Reserve: length,location: 32768, 30670 expected:  32768, 48
> 
> I likewise find these interesting.  Don't know yet what they mean - 
> again I say "Ben wrote udf.ko, not I".
> 
> I'll try to hunt for relevant claims in the 
> udfct/src/udf_tester/udf_test (aka phgfsck) output when I receive it.
> 
> // David Burg:
> 
> >> Let me know if you ... think ... Nero has a mistake
> 
> Wow.  Will do with pleasure thank you for your interest.
> 
> Pat LaVarre
> 
