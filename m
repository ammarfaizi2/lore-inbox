Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbUCTUvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbUCTUvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:51:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263536AbUCTUve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:51:34 -0500
Message-ID: <405CAEC7.9080104@pobox.com>
Date: Sat, 20 Mar 2004 15:51:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net>
In-Reply-To: <405C8B39.8080609@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Hi,
> 
> [sorry for the crosspost]
> 
> a few hours ago I read on lkml that development to support ATARAID
> variants as a dm target is underway. Is that correct? If not, I might be
> interested in writing such a target.

It's not underway AFAIK, but Arjan and I "keep meaning to do it."

So go ahead, and I'll lend you as much help as I can.  I have the full 
Promise RAID docs, and it seems like another guy on the lists has full 
Silicon Image "medley" RAID docs...

	Jeff



