Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTLESQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTLESQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:16:41 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:61162 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264261AbTLESQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:16:37 -0500
Message-ID: <3FD0CB76.4000202@backtobasicsmgmt.com>
Date: Fri, 05 Dec 2003 11:16:22 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <20031204081732.GC5376@launay.org> <3FCF4C32.5040101@pobox.com> <200312051842.26599.marchand@kde.org> <3FD0C4B0.8020106@pobox.com>
In-Reply-To: <3FD0C4B0.8020106@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Yes, a tested patch would be great, thanks!
> 

(hijacking this subthread, sorry)

Jeff, you mentioned in the status report "don't remove an operating disk 
from an ICH5, hotplug is not supported".

Does this mean hardware damage, or just serious libata/ICH5 confusion? 
I've got a six-disk server here with two disks on an ICH5 and four on an 
SATA150 TX4, and I really would like to be able to hot-replace a disk in 
case of a failure. If the ICH5 cannort support this, I'm going to have 
to get a 3ware card.

