Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbTIJACj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbTIJACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:02:39 -0400
Received: from mrout3.yahoo.com ([216.145.54.173]:37637 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S265040AbTIJACi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:02:38 -0400
Message-ID: <3F5E6A10.8050604@bigfoot.com>
Date: Tue, 09 Sep 2003 17:02:24 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac2
References: <200309092334.h89NYxh18536@devserv.devel.redhat.com>
In-Reply-To: <200309092334.h89NYxh18536@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> (No its not course start time quite yet..)
> 
> Various little fixups and tidying bits. Some of these probably want to
> get pushed on to Marcelo eventually - the small bits and the CMPCI update
> certainly.
> 
> Linux 2.4.22-ac2
...
> o	SATA driver core update				(Jeff Garzik)

...
> Linux 2.4.21rc1-ac4
...
> o	Intel ICH5 basic SATA support			(Andre Hedrick)
...


   does this include the fix to make it possible to use >137GB drives 
with SCSI_ATA? (I think that's libata5 patch)

   (I have intel D865PERL, maxtor 250GB SATA drive used with SCSI_ATA 
kernel config option, currently use 2.4.21-ac4 (for SCSI_ATA) + libata5 
(for 137+ GB support) patches)

   TIA,

	erik

