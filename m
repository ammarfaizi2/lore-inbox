Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUG2RK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUG2RK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUG2RIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:08:17 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:20214 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264791AbUG2RGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:06:34 -0400
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090205@piramida.hermes.si>
References: <B1ECE240295BB146BAF3A94E00F2DBFF090205@piramida.hermes.si>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <AC3C5901-E181-11D8-8AD5-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: "'David Burg'" <dburg@nero.com>, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: Can not read UDF CD
Date: Thu, 29 Jul 2004 11:06:46 -0600
To: David Balazic <david.balazic@hermes.si>
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 29 Jul 2004 17:06:28.0230 (UTC) FILETIME=[63239A60:01
	C4758E]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:12.44589 C:9 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// David Balazic:

> I will try to see if the problem is reproducable with burning
> more UDF CDs...

Yes please thank you.

>> I attach the "udf_test -scsi 1:0" output.

Attach did Not arrive here, sorry, please retry attach, at least to me, 
else publish on web.

Also please say if you can easily share a .iso image of the disc.  (Of 
course I imagine linux_udf and linux-kernel don't want that attached.)

>> -	   Main: length,location: 32768, 30654 expected:  32768, 32
>> -	Reserve: length,location: 32768, 30670 expected:  32768, 48

I likewise find these interesting.  Don't know yet what they mean - 
again I say "Ben wrote udf.ko, not I".

I'll try to hunt for relevant claims in the 
udfct/src/udf_tester/udf_test (aka phgfsck) output when I receive it.

// David Burg:

>> Let me know if you ... think ... Nero has a mistake

Wow.  Will do with pleasure thank you for your interest.

Pat LaVarre

