Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTAUVrG>; Tue, 21 Jan 2003 16:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbTAUVrG>; Tue, 21 Jan 2003 16:47:06 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:17041 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S267228AbTAUVrE>; Tue, 21 Jan 2003 16:47:04 -0500
Date: Tue, 21 Jan 2003 13:56:02 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32bit dev_t
Message-ID: <20030121215602.GI20972@ca-server1.us.oracle.com>
References: <20030121195041.GE20972@ca-server1.us.oracle.com> <3E2DBBAD.80206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2DBBAD.80206@mvista.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 02:29:17PM -0700, Steven Dake wrote:
> Linux doesn't really need a 32 bit kdev_t structure to support 1000 
> disks.  There is plenty of device space available to support over 1500 
> disks by modifying the linux scsi layer.

	First, that's an approach that removes space from other devices.
In addition, I suspect we'll see 2000 disk systems before we see 2.8.

Joel


-- 

"I am working for the time when unqualified blacks, browns, and
 women join the unqualified men in running our overnment."
	- Sissy Farenthold

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
