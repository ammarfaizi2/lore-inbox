Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268468AbRHBScm>; Thu, 2 Aug 2001 14:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHBScW>; Thu, 2 Aug 2001 14:32:22 -0400
Received: from f83.law7.hotmail.com ([216.33.237.83]:32528 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268468AbRHBScU>;
	Thu, 2 Aug 2001 14:32:20 -0400
X-Originating-IP: [198.252.187.206]
From: "daniel sheltraw" <l5gibson@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: filesystem problem
Date: Thu, 02 Aug 2001 13:32:24 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F83srxPx83BcTbnoRiC000098a9@hotmail.com>
X-OriginalArrivalTime: 02 Aug 2001 18:32:24.0520 (UTC) FILETIME=[79700480:01C11B81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel

I am having a fsck problem and do not know how to solve it most
effectively.  I am running 2.2.14 (Redhat 6.2). When booting I
get the following message:

Checking root filesystem /dev/hda5 contains a file system with errors,
   check forced.
/dev/hda5
Unattached inode 198516

/dev/hda5: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY. (ie., without
        -a or -p options)

Can someone please tell me how to use fsck to fix this
filesystem problem? Also if you know of a better place to
post such questions (kernel development list hardly seems
appropriate) would you please tell me where.



Thanks,
Daniel

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

