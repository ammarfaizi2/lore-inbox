Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTIYP2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIYP2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:28:40 -0400
Received: from users.linvision.com ([62.58.92.114]:15567 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261311AbTIYP2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:28:39 -0400
Date: Thu, 25 Sep 2003 17:28:37 +0200
From: Erik Mouw <erik@harddisk-recovery.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
       "'Lou Langholtz'" <ldl@aros.net>, linux-kernel@vger.kernel.org
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Message-ID: <20030925152837.GF31199@bitwizard.nl>
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA871@E151000N0> <200309251644.22539.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309251644.22539.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 04:44:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> IDE limit is 137GB, not 128GB.

It's the same limit:

erik@zurix:~ >bc -l
bc 1.06
Copyright 1991-1994, 1997, 1998, 2000 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type warranty'. 
128 * 1024 * 1024 * 1024 / 1000000000
137.43895347200000000000


Regards,
Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost?!
| Stay calm and contact Harddisk-recovery.com!
