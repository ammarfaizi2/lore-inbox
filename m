Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTKHSMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTKHSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:12:50 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:39865 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261909AbTKHSMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:12:48 -0500
Message-ID: <3FAD3215.9010400@backtobasicsmgmt.com>
Date: Sat, 08 Nov 2003 11:12:37 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata testing on new machine with ICH5 and PDC20318
References: <3FACC17C.7070901@backtobasicsmgmt.com> <3FAD2CB6.5070508@pobox.com>
In-Reply-To: <3FAD2CB6.5070508@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> The ICH5 should be fine.  You may need to twiddle BIOS setup options, 
> some users have reported that both drivers/ide and libata fail in 
> certain BIOS modes.  "Enhanced - SATA only" is usually the preferred 
> mode, where feasible.

I forgot to mention I will not be booting off of any of the SATA disks, 
so that should cover the BIOS issues by just ignoring them.

> 
> You need to make sure you get the Promise SATA fixes I just pushed to 
> Linus.  Presumably they will be available in the next 2.6.0-testX BK 
> snapshot on ftp.kernel.org, tonight or the next night.

I saw that message; I won't have the hardware until late next week, so 
I'll watch to see what happens with the snapshot/-testX situation by then.

I'll have about three weeks to use the machine for "whatever" before I 
have to start preparing it for its real purpose, so if there's any 
stress tests or anything I else I can run that would be useful let me know.

