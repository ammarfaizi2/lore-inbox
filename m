Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279926AbRKIP4p>; Fri, 9 Nov 2001 10:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279944AbRKIP4g>; Fri, 9 Nov 2001 10:56:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:11025 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279926AbRKIP4c>;
	Fri, 9 Nov 2001 10:56:32 -0500
Subject: Re: [PATCH] Adding KERN_INFO to some printks #2
From: Robert Love <rml@tech9.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01110913474600.02130@nemo>
In-Reply-To: <01110913474600.02130@nemo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 09 Nov 2001 10:56:21 -0500
Message-Id: <1005321383.1209.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-09 at 08:47, vda wrote:
> Primary purpose of this patch is to make KERN_WARNING and
> KERN_INFO log levels closer to their original meaning.
> Today they are quite far from what was intended.
> Just look what kernel writes at the WARNING level
> each time you boot your box!

This is an _excellent_ patch and you should proffer it to Linus and Alan
when you are done.  I would recommend diffing off 2.4.14 instead of
2.4.13, to this end.

I haven't gone over the actual loglevel warnings, but I plan to.  A
quick glimpse shows you are changing what needs to be changed.  Good
job.

> Patch can be found at
> http://port.imtp.ilyichevsk.odessa.ua/linux/vda/KERN_INFO-2.4.13.diff
> 
> or emailed on request (our www server isn't exactly powerful, you may
> have difficulty downloading the patch)

Yah it was slow but it worked :)

	Robert Love

