Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbSJ3C7i>; Tue, 29 Oct 2002 21:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbSJ3C7i>; Tue, 29 Oct 2002 21:59:38 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:21824
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S263293AbSJ3C7h>; Tue, 29 Oct 2002 21:59:37 -0500
Message-ID: <3DBF4DBA.8060005@rackable.com>
Date: Tue, 29 Oct 2002 19:10:50 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 03:06:00.0026 (UTC) FILETIME=[4609D3A0:01C27FC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:

> Hi,
>
> First release of squashfs.  Squashfs is a highly compressed read-only 
> filesystem for Linux (kernel 2.4.x).  It uses zlib compression to 
> compress both files, inodes and directories.  Inodes in the system are 
> very small and all blocks are packed to minimise data overhead. Block 
> sizes greater than 4K are supported up to a maximum of 32K.
>
> Squashfs is intended for general read-only filesystem use, for 
> archival use, and in embedded systems where low overhead is needed.
>
> Squashfs is available from http://squashfs.sourceforge.net.
>
> The patch file is currently against 2.4.19.  There is further info on 
> the filesystem design etc. in the README.
>
> I'l be interested in getting any feedback, advice etc. on it.
>

  What are the advantages of squashfs vs cramfs?


