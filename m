Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290733AbSAYRSz>; Fri, 25 Jan 2002 12:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290736AbSAYRSp>; Fri, 25 Jan 2002 12:18:45 -0500
Received: from tux.gsfc.nasa.gov ([128.183.191.134]:42187 "EHLO
	tux.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id <S290733AbSAYRSj>; Fri, 25 Jan 2002 12:18:39 -0500
Date: Fri, 25 Jan 2002 12:18:37 -0500
From: John Kodis <kodis@mail630.gsfc.nasa.gov>
To: linux-kernel@vger.kernel.org
Cc: palmerj@zanshin.gsfc.nasa.gov
Subject: Mounting OS-X "Unix" filesystems on Linux
Message-ID: <20020125171837.GA31376@tux.gsfc.nasa.gov>
Mail-Followup-To: John Kodis <kodis@mail630.gsfc.nasa.gov>,
	linux-kernel@vger.kernel.org, palmerj@zanshin.gsfc.nasa.gov
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to mount an OS-X Unix filesystem on Linux.  I haven't had
any luck at this, and wondered whether this is a known problem, or if
I'm doing something wrong.

I formatted a zip disk on a Mac OS-X, selecting the "Unix" filesystem
type and no partitions.  I then inserted this disk in the /dev/hdd,
the zip drive on my PC.  I tried mounting hdd and hdd1 through hdd4
using types of auto, ufs, udf, sysv, and one or two others, all to no
avail.

-- 
John Kodis                                    Goddard Space Flight Center
kodis@mail630.gsfc.nasa.gov                      Greenbelt, Maryland, USA
Phone: 301-286-7376                                     Fax: 301-286-1771
