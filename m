Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUARR7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 12:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUARR7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 12:59:03 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:63120 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262126AbUARR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 12:59:01 -0500
Message-ID: <400AC95D.8030201@backtobasicsmgmt.com>
Date: Sun, 18 Jan 2004 10:58:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: der.eremit@email.de, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Making MO drive work with ide-cd
References: <UTC200401181718.i0IHI5F26519.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200401181718.i0IHI5F26519.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> Don't know whether Jens really wants to bend ide-cd.c until
> it also handles disks, but it smells like a hack.

Is Jeff Garzik's libata ever going to support parallel ATA? If so, 
doesn't that handle this situation nicely, given that the SCSI sd module 
should already know how to handle SCSI MO drives?

