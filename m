Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTDDSsd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTDDSsd (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:48:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48325 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263895AbTDDSsd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:48:33 -0500
Message-ID: <3E8DD614.1060500@us.ibm.com>
Date: Fri, 04 Apr 2003 10:59:32 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: andrew <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Testing with 4000 disks
References: <200304041024.33418.pbadari@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> I ran out of lowmem. I am wondering why I have so much
> ext3_inode_cache. All 4000 filesystems are ext2.

What does /proc/mounts say?

-- 
Dave Hansen
haveblue@us.ibm.com

