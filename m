Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTDDTQb (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTDDTQb (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:16:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:48321 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263946AbTDDTQb convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:16:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: Testing with 4000 disks
Date: Fri, 4 Apr 2003 11:25:40 -0800
User-Agent: KMail/1.4.1
Cc: andrew <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200304041024.33418.pbadari@us.ibm.com> <3E8DD614.1060500@us.ibm.com>
In-Reply-To: <3E8DD614.1060500@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304041125.40018.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 April 2003 10:59 am, Dave Hansen wrote:
> Badari Pulavarty wrote:
> > I ran out of lowmem. I am wondering why I have so much
> > ext3_inode_cache. All 4000 filesystems are ext2.
>
> What does /proc/mounts say?

# grep ext3 /proc/mounts
/dev/root / ext3 rw 0 0

- Badari
