Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFOOLC>; Sat, 15 Jun 2002 10:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSFOOLB>; Sat, 15 Jun 2002 10:11:01 -0400
Received: from c0s14.ami.com.au ([203.55.31.79]:11021 "EHLO
	dugite.summer.ami.com.au") by vger.kernel.org with ESMTP
	id <S315412AbSFOOLA>; Sat, 15 Jun 2002 10:11:00 -0400
Message-Id: <200206151408.g5FE8s731047@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map 
In-Reply-To: Message from Kurt Garloff <garloff@suse.de> 
   of "Sat, 15 Jun 2002 15:36:06 +0200." <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Jun 2002 22:08:54 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Life would be easier if the scsi subsystem would just report which SCSI
> device (uniquely identified by the controller,bus,target,unit tuple) belongs
> to which high-level device. The information is available in the kernel.


Does this not fail if I pull a device off, change its ID (perhaps to fit into another system), then plug it in again? Or if I move it from one adaptor to another?





-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.

==============================
If you don't like being told you're wrong,
	be right!



