Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUDQIHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbUDQIHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:07:07 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:18831 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S263722AbUDQIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:07:00 -0400
Message-ID: <4080E4ED.5010008@superonline.com>
Date: Sat, 17 Apr 2004 11:03:57 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Willy Tarreau <w@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA support in 2.4.27
References: <4080E1A1.7030606@superonline.com> <20040417080403.GF596@alpha.home.local>
In-Reply-To: <20040417080403.GF596@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Apr 17, 2004 at 10:49:53AM +0300, O.Sezer wrote:
> 
>>Comments in  ChangeSet 1.1366 -> 1.1367  say:
>>
>># This adds all the SATA drivers except Intel ICH5/ICH6 ("ata_piix").
>># ata_piix was the cause of all the ____request_resource() and PCI quirk
>># nastiness.  As you can see, without that driver, the patch is nice and
>># clean, and does nothing but add files.
>>
>>Shall we people who can stand unclean and ugly trees have a separate
>>patch for ata_piix please ;))
> 
> 
> It's on Jeff's site : www.kernel.org/pub/linux/kernel/people/jgarzik/libata/
> Notice that 2.4.26-bk1-libata1 is fairly smaller than 2.4.26-rc1-libata1 :-)
> 
> Willy
> 

Ooops, missed that! Thank you very much.

Özkan Sezer

