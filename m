Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUCUSpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUCUSpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:45:34 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:27015 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263697AbUCUSp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:45:27 -0500
Message-ID: <405DE2B6.7060003@backtobasicsmgmt.com>
Date: Sun, 21 Mar 2004 11:45:10 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com> <405DE18B.7090505@gmx.net>
In-Reply-To: <405DE18B.7090505@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> - Would an EVMS plugin or a simple script calling dmsetup be the way to
> go? If I go the dmsetup route, is there any chance to get partition
> detection on top of the ATARAID for free (by calling another dm tool)?

This was posted a while back; I don't know what the status of it being 
merged into util-linux is.

http://lwn.net/Articles/13958/
