Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSE3PK0>; Thu, 30 May 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSE3PKZ>; Thu, 30 May 2002 11:10:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10485 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316681AbSE3PKY>; Thu, 30 May 2002 11:10:24 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3CF62F2A.6030009@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 17:13:39 +0100
Message-Id: <1022775219.9255.385.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 14:54, Martin Dalecki wrote:
> I don't use and don't care about devfs - it's a misconception in my opinnion.

Yes but there are lots of other opinions. And it was just one of several
examples of why you were proposing something utterly bogus


> And last but not least: some devices which should be viewd as "same type"
> are hooked up to different major numbers instead of sharing them.
> Most prominent here are the differences between SCSI disks and ATA disks
> for example. From a technical point of view they don't make *any* sense.

Linus has explicitly stated he wants to do this and make all disks
appear the same and the same place. It actually makes lots of sense. 

 

