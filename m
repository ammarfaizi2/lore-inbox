Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUBZCyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbUBZCyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:54:31 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:25006 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261639AbUBZCya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:54:30 -0500
Message-ID: <403D5FE1.1070203@matchmail.com>
Date: Wed, 25 Feb 2004 18:54:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
References: <403D5B3D.6060804@pobox.com>
In-Reply-To: <403D5B3D.6060804@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> VIA
> ---
> Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
> control including hotplug and PM.
> 
> libata driver status:  Beta.

Does drivers/ide support this also?
