Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269120AbRHBUaW>; Thu, 2 Aug 2001 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269118AbRHBUaM>; Thu, 2 Aug 2001 16:30:12 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:63726 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269144AbRHBUaD>; Thu, 2 Aug 2001 16:30:03 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292058.f6TKwUU01512@bagpuss.swansea.linux.org.uk>
Subject: Re: harddisk suddenly locked?!
To: tanner@ffii.org (Thomas Tanner)
Date: Sun, 29 Jul 2001 16:58:30 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MABBKEJEMCFLBEDCGCDNGEABCAAA.tanner@ffii.org> from "Thomas Tanner" at Jul 31, 2001 01:00:07 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  A locked drive rejects all media access commands.
>  When a new master password is set, the drive won't be locked.
>  Setting a new user password locks the drive the next time it is powered-on.
> 
>  Something must have sent a lock command to my hd. Maybe a bug in the IDE
> code?

Or someone broke into the box and did it. In fact given this feature
is actually enabled on ibm disks Im amazed the windows viruses havent
all started doing it

