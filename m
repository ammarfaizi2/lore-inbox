Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290853AbSASALq>; Fri, 18 Jan 2002 19:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290883AbSASALg>; Fri, 18 Jan 2002 19:11:36 -0500
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:64185 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S290853AbSASAL2>;
	Fri, 18 Jan 2002 19:11:28 -0500
X-Sent: 19 Jan 2002 00:11:22 GMT
Message-ID: <3C48B9A5.4E3380A3@bigfoot.com>
Date: Fri, 18 Jan 2002 16:11:17 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Autostart RAID 1+0 (root)
In-Reply-To: <001201c1a03e$e654acd0$9865fea9@pcsn630778>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alok K. Dhir" wrote:
> 
> Hey all - I may be trying to do the impossible here, but here goes:
> 
> I want to test using a software RAID 1+0 partition as root: md0 and md1
> set up as mirrors between two disks each, and md2 set up as a stripe
> ...

http://www.linuxdoc.org/HOWTO/Boot+Root+Raid+LILO.html , appendix C & D.

May also be useful:
http://www.redhat.com/support/resources/tips/raid/RAID-INDEX.html
--
