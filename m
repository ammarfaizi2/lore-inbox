Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSI3N6Z>; Mon, 30 Sep 2002 09:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbSI3N53>; Mon, 30 Sep 2002 09:57:29 -0400
Received: from [203.117.131.12] ([203.117.131.12]:50388 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262070AbSI3Nxv>; Mon, 30 Sep 2002 09:53:51 -0400
Message-ID: <3D9858AE.7080606@metaparadigm.com>
Date: Mon, 30 Sep 2002 21:59:10 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Kevin Corry <corryk@us.ibm.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
References: <200209290114.15994.jdickens@ameritech.net> <20020929214652.GF12928@merlin.emma.line.org> <3D97F7AE.5070304@metaparadigm.com> <02093008055700.15956@boiler>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 09/30/02 21:05, Kevin Corry wrote:
> EVMS is now up-to-date and running on 2.5.39. You can get the latest kernel 
> code from CVS (http://sourceforge.net/cvs/?group_id=25076) or Bitkeepr 
> (http://evms.bkbits.net/). There will be a new, full release (1.2) coming out 
> this week.

Seems you guys are the furthest ahead for a working logical volume manager
in 2.5. Does the EVMS team plan to send patches for 2.5 before the freeze?

It would be great to have EVMS in 2.5 (assuming the community approves of
EVMS going in). Seems to be very non-invasive touching almost no common code.

How far along are you with the clustering support (distributed locking of
cluster metadata and update notification, etc)? This is what i'm really after.

~mc

