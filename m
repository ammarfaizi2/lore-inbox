Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSCDOgp>; Mon, 4 Mar 2002 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292386AbSCDOgY>; Mon, 4 Mar 2002 09:36:24 -0500
Received: from ccs.covici.com ([209.249.181.196]:1438 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S292389AbSCDOgX>;
	Mon, 4 Mar 2002 09:36:23 -0500
Date: Mon, 4 Mar 2002 09:36:03 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.6-pre1/drivers/scsi/advansys.c DMA-mapping
 fixes
In-Reply-To: <200203041208.EAA04128@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.40.0203040934540.6915-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, after the patch is applied I get the error -- without the patch
it won't even compile.

On Mon, 4 Mar 2002, Adam J. Richter wrote:

> >I got the following error when trying to install the advansys scsi
> >driver as a module:
>
> >depmod:         virt_to_bus_not_defined_use_pci_map
>
> 	Do you mean that you get this error after applying my patch?
>
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
>

-- 
         John Covici
         covici@ccs.covici.com

