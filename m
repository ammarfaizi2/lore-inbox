Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbUKQUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUKQUnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKQUlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:41:49 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:27665 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262519AbUKQUjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:39:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cpqarray: Correct mailing list address in source code
Date: Wed, 17 Nov 2004 14:38:59 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0037@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray: Correct mailing list address in source code
Thread-Index: AcTMMYPHumwEtIyBQ7mq9udpD7+SNwAs+gVA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <james4765@verizon.net>, <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
X-OriginalArrivalTime: 17 Nov 2004 20:39:00.0145 (UTC) FILETIME=[77B9AA10:01C4CCE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct mailing list address in cpqarray source code.
> 
> diffstat output:
> 
>  cpqarray.c  |    2 +-
>  cpqarray.h  |    2 +-
>  ida_cmd.h   |    2 +-
>  ida_ioctl.h |    2 +-
>  smart1,2.h  |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> Signed-off-by: James Nelson <james4765@gmail.com>

This is OK. 

Signed-off-by: Mike Miller <mike.miller@hp.com>

> 
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/cpqarray.c 
> linux-2.6.10-rc2/drivers/block/cpqarray.c
> --- linux-2.6.10-rc2-original/drivers/block/cpqarray.c	
> 2004-11-15 21:38:15.707432667 -0500
> +++ linux-2.6.10-rc2/drivers/block/cpqarray.c	2004-11-16 
> 17:26:45.127423447 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to 
> Cpqarray-discuss@lists.sourceforge.net
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   */
>  #include <linux/config.h>	/* CONFIG_PROC_FS */
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/cpqarray.h 
> linux-2.6.10-rc2/drivers/block/cpqarray.h
> --- linux-2.6.10-rc2-original/drivers/block/cpqarray.h	
> 2004-10-18 17:54:37.000000000 -0400
> +++ linux-2.6.10-rc2/drivers/block/cpqarray.h	2004-11-16 
> 17:26:24.440216288 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   *    If you want to make changes, improve or add 
> functionality to this
>   *    driver, you'll probably need the Compaq Array 
> Controller Interface
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/ida_cmd.h 
> linux-2.6.10-rc2/drivers/block/ida_cmd.h
> --- linux-2.6.10-rc2-original/drivers/block/ida_cmd.h	
> 2004-10-18 17:53:45.000000000 -0400
> +++ linux-2.6.10-rc2/drivers/block/ida_cmd.h	2004-11-16 
> 17:26:12.178871611 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   */
>  #ifndef ARRAYCMD_H
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/ida_ioctl.h 
> linux-2.6.10-rc2/drivers/block/ida_ioctl.h
> --- linux-2.6.10-rc2-original/drivers/block/ida_ioctl.h	
> 2004-10-18 17:54:08.000000000 -0400
> +++ linux-2.6.10-rc2/drivers/block/ida_ioctl.h	
> 2004-11-16 17:25:57.796813237 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   */
>  #ifndef IDA_IOCTL_H
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/smart1,2.h 
> linux-2.6.10-rc2/drivers/block/smart1,2.h
> --- linux-2.6.10-rc2-original/drivers/block/smart1,2.h	
> 2004-10-18 17:54:37.000000000 -0400
> +++ linux-2.6.10-rc2/drivers/block/smart1,2.h	2004-11-16 
> 17:25:48.198109094 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   *    If you want to make changes, improve or add 
> functionality to this
>   *    driver, you'll probably need the Compaq Array 
> Controller Interface
> 
