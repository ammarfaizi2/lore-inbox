Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUHIObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUHIObD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUHIO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:29:12 -0400
Received: from guardian.hermes.si ([193.77.5.150]:21765 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S266646AbUHIO2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:28:06 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090213@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: "'David Burg'" <dburg@nero.com>, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: RE: Can not read UDF CD
Date: Mon, 9 Aug 2004 16:27:48 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I put the ISO image and the udf checker outputs on BitTorrent,
the torrent file is avaliable at
http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent

In case you don't have a BitTorrent client, one can be had at
http://bitconjurer.org/BitTorrent/download.html
( even a commandline version , written in python )

Regards,
David


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
