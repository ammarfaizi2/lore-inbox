Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbUKQUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUKQUnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUKQUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:42:05 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:10513 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262501AbUKQUiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:38:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cciss: Correct mailing list address in source code
Date: Wed, 17 Nov 2004 14:38:16 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0036@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: Correct mailing list address in source code
Thread-Index: AcTMMUoLjS1el1rrSZO9zam4OPNIIgAs/pYg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <james4765@verizon.net>, <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
X-OriginalArrivalTime: 17 Nov 2004 20:38:17.0818 (UTC) FILETIME=[5E7F13A0:01C4CCE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct mailing list address in cciss source code.
> 
> diffstat output:
> 
>  cciss.c      |    2 +-
>  cciss_scsi.c |    2 +-
>  cciss_scsi.h |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Signed-off-by: James Nelson <james4765@gmail.com>

This is OK. 

Signed-off-by: Mike Miller <mike.miller@hp.com>

> 
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/cciss.c 
> linux-2.6.10-rc2/drivers/block/cciss.c
> --- linux-2.6.10-rc2-original/drivers/block/cciss.c	
> 2004-11-15 21:38:15.683435907 -0500
> +++ linux-2.6.10-rc2/drivers/block/cciss.c	2004-11-16 
> 17:27:02.056138014 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to 
> Cciss-discuss@lists.sourceforge.net
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   */
>  
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/cciss_scsi.c 
> linux-2.6.10-rc2/drivers/block/cciss_scsi.c
> --- linux-2.6.10-rc2-original/drivers/block/cciss_scsi.c	
> 2004-11-15 21:38:15.685435637 -0500
> +++ linux-2.6.10-rc2/drivers/block/cciss_scsi.c	
> 2004-11-16 17:47:28.924506697 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *    
>   *    Author: Stephen M. Cameron
>   */
> diff -urN --exclude='*~' 
> linux-2.6.10-rc2-original/drivers/block/cciss_scsi.h 
> linux-2.6.10-rc2/drivers/block/cciss_scsi.h
> --- linux-2.6.10-rc2-original/drivers/block/cciss_scsi.h	
> 2004-10-18 17:54:22.000000000 -0400
> +++ linux-2.6.10-rc2/drivers/block/cciss_scsi.h	
> 2004-11-16 17:47:21.868459287 -0500
> @@ -16,7 +16,7 @@
>   *    along with this program; if not, write to the Free Software
>   *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - *    Questions/Comments/Bugfixes to arrays@compaq.com
> + *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
>   *
>   */
>  #ifdef CONFIG_CISS_SCSI_TAPE
> 
