Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHOPNh>; Thu, 15 Aug 2002 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHOPNh>; Thu, 15 Aug 2002 11:13:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:22279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317101AbSHOPNg>;
	Thu, 15 Aug 2002 11:13:36 -0400
Date: Thu, 15 Aug 2002 08:17:28 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: anybody porting 2.4.19 i/o stat patches to 2.5?
In-Reply-To: <200208150124.g7F1Ob401335@eng4.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0208150816160.28871-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Rick Lindsley wrote:

| These patches allowed you to collect I/O information on a per-partition
| basis, as well as removing the restriction about only monitoring the
| first sixteen disks.  Is anybody working on porting this to 2.5?  If not,
| I'll do it.
|
| These 2.4.19 patches did not, it appear, provide any means (through
| /proc, for example, as in the original patches) of retrieving the
| information even though code was added to collect it.  Any reason why not?

I've started doing it, although I'm currently at LinuxWorld
and won't have more time for it until next week.

Don't know about the second part..

-- 
~Randy

