Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289646AbSAJTtD>; Thu, 10 Jan 2002 14:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSAJTsv>; Thu, 10 Jan 2002 14:48:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289646AbSAJTsm>; Thu, 10 Jan 2002 14:48:42 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Thu, 10 Jan 2002 20:00:02 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), axboe@suse.de (Jens Axboe),
        pbadari@us.ibm.com (Badari Pulavarty),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, axboe@brick.kernel.dk
In-Reply-To: <200201101924.g0AJO6s02748@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 10, 2002 11:24:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OlMo-0005NV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this address everyones concerns ? I am willing to work with the
> drivers I tested/reviewed/verified to make the change to set the flag.
> As driver owners verify their drivers, could set the flag (in future).

Im just trying to work out how this deals with the 2.4 scsi case
