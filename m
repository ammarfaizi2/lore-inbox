Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264943AbUEVLne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUEVLne (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 07:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUEVLne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 07:43:34 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:470 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264943AbUEVLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 07:43:31 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm5
Date: Sat, 22 May 2004 13:51:37 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20040522013636.61efef73.akpm@osdl.org> <40AF18E7.4040509@pobox.com>
In-Reply-To: <40AF18E7.4040509@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405221351.37361.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 of May 2004 11:09, Jeff Garzik wrote:
> Andrew Morton wrote:
> > - Added a new SATA RAID driver from 3ware.  From a quick peek it seem to
> >   need a little work yet.
>
> It's not too bad... but it looks more like a 2.2 driver forward ported
> to 2.4, than a 2.6.x driver.  Needs some luvin' from the 2.6 scsi api crew.
>
> Overall, it appears to be a message-based firmware engine like
> drivers/block/carmel.c, that hides the SATA details in the firmware.

BTW, which 3ware driver would you suggest to use with the 2.6.x now?  I'm 
going to install such a controller in my box ...

RJW

