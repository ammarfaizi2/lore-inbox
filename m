Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTBXI5H>; Mon, 24 Feb 2003 03:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBXI5H>; Mon, 24 Feb 2003 03:57:07 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:11486 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264867AbTBXI5H>; Mon, 24 Feb 2003 03:57:07 -0500
Importance: Normal
Sensitivity: 
Subject: Re: ioctl32 consolidation
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF1C19BD55.488C2F5A-ONC1256CD7.0036D692@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 24 Feb 2003 11:05:56 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 24/02/2003 10:07:01
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For s390, I'd love to see progress in the consolidation. Feel free to
> submit changes for arch/s390x/kernel/ioctl32.c directly, like
> Stephen Rothwell does for the syscall32 consolidation. Of course,
> Martin has the last word here, but I'm rather sure he agress with me
> in this.
Everything that moves out of arch/s390x/kernel/ioctl32.c has my blessing.
I am currently working on the 31 bit emulation. It almost works again and
I will include the changes in the next patch set.

blue skies,
   Martin



