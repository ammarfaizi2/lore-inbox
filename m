Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVAJQqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVAJQqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVAJQqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:46:00 -0500
Received: from static-129-44-218-101.syr.east.verizon.net ([129.44.218.101]:18356
	"EHLO internal-server.acipower1.com") by vger.kernel.org with ESMTP
	id S262323AbVAJQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:45:54 -0500
Message-Id: <200501101650.j0AGoME4031076@internal-server.acipower1.com>
From: "Andrey Klochko" <aklochko@acipower.com>
To: "'Peter Daum'" <gator@cs.tu-berlin.de>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Date: Mon, 10 Jan 2005 11:45:29 -0500
Organization: Applied Concepts, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.30.0501101452590.14606-100000@swamp.bayern.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcT3HWAAqmDGGGpRTxyQw8gnSBHduwAFjq8g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try "Download 'In Engineering Phase' Software" link?

Andrey 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Peter Daum
Sent: Monday, January 10, 2005 8:57 AM
To: Christoph Hellwig
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry

On Mon, 10 Jan 2005, Christoph Hellwig wrote:

> On Mon, Jan 10, 2005 at 02:03:32PM +0100, Peter Daum wrote:
> >
> > It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> > has been removed (or actually moved to sysfs).
> > Unfortunately, this breaks all the (binary only )-: tools provided by
> > 3ware, which are indispensable for system maintenance.
>
> The change came from the driver maintainer at 3ware.  Get the updated
> tools from their website.

Which website do you mean? The programs in the download section of
"www.3ware.com" are just the ones that don't work anymore.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

