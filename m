Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbUAXUPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267005AbUAXUPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:15:34 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:166 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S267004AbUAXUPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:15:30 -0500
Message-ID: <4012D258.6010201@mnsu.edu>
Date: Sat, 24 Jan 2004 14:15:20 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "XFS: linux-xfs@oss.sgi.com" <linux-xfs@oss.sgi.com>,
       marcelo.tosatti@cyclades.com
Subject: 2.4.24 with the 2.4.23-xfs patches from sgi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the last 48-hours we've had two machines hang with no messages on the 
console and none in the logs, pings return, drive lights are all off and 
don't ever flash.   Both machines we running linux-2.4.24 with the 
xfs-2.4.23-all-i386 patch as recommended by the XFS group.  These 
machines had been running fine on this kernel image since Jan  13, 
2004.  One machine was running XFS as a filesystem and the other was 
running EXT2.  These machines have both been in constant production for 
over 4 years and there has not been any hardware changes, including 
those to it's environment with is power and temperature controlled.

Both machines are Pentium-3 class, 256M of memory, both using SCSI disk 
with different SCSI controllers.  This is the the version string:
Linux version 2.4.24-xfs (j3gum@krypton) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 SMP Tue Jan 13 22:05:12 CST 2004

If you need more specific info. I'll prob. keep these and the other 
dozen on the same kernel image up for a few more days.
-- 
jeffrey hundstad

