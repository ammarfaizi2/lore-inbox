Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267247AbUBMXvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBMXvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:51:02 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:25565 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S267247AbUBMXtm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:49:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: what is the best 2.6.2 kernel code?
Date: Fri, 13 Feb 2004 16:49:40 -0700
Message-ID: <0A78D025ACD7C24F84BD52449D8505A15A80D1@wcosmb01.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what is the best 2.6.2 kernel code?
Thread-Index: AcPygfTSfrMI3L/SSiyrgO7gA7b3kwACWkgQ
From: <yiding_wang@agilent.com>
To: <riel@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Feb 2004 23:49:41.0251 (UTC) FILETIME=[0C516530:01C3F28C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks fro all of your explanation.  It looks like I have to make sure all my software is updated for 2.6.2 build process (my original linux is 2.4.18.  I will check and try it again!

Thanks again!

Eddie

> -----Original Message-----
> From: Rik van Riel [mailto:riel@redhat.com]
> Sent: Friday, February 13, 2004 2:37 PM
> To: WANG,YIDING (A-SanJose,ex1)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: what is the best 2.6.2 kernel code?
> 
> 
> On Fri, 13 Feb 2004 yiding_wang@agilent.com wrote:
> 
> > I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2 
> from kernel
> > source.  Both files are dated 03-Feb.-2004.
> > 
> > Building new kernel from the source failed on fs/proc/array.o.  
> > Patching with patch file will have numerous warning message 
> which says
> > "Reversed patch detected! Assume -R [n]".
> 
> linux-2.6.1 + patch-2.6.2 results in linux-2.6.2
> 
> If you download linux-2.6.2 you don't need to apply
> any patches.
> 
> Please see http://www.kernelnewbies.org/
> 
> cheers,
> 
> Rik
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
> 
