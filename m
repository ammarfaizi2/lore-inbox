Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSILTps>; Thu, 12 Sep 2002 15:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSILTps>; Thu, 12 Sep 2002 15:45:48 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43137 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317101AbSILTpr>; Thu, 12 Sep 2002 15:45:47 -0400
Message-Id: <200209121950.g8CJo6D15548@eng4.beaverton.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34 
In-reply-to: Your message of "Thu, 12 Sep 2002 11:49:25 PDT."
             <3D80E1B5.7B3B8AA0@digeo.com> 
Date: Thu, 12 Sep 2002 12:50:06 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
    Erm... Some of /proc/stat data has no relations to disks, namely CPU counts.
    It would be strange to have CPU stats in /proc/diskstats...

and Andrew Morton responded:
    Rick is proposing that all the disk stuff be in /proc/diskstat and
    that all the process stuff be in /proc/stat.  ie: move all the disk
    accounting out of /proc/stat.

Right. diskstat or some other arbitrary name (I haven't been argued to
a different one yet :)

Rick
