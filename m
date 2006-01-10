Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWAJXzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWAJXzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWAJXzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:55:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:29429 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932321AbWAJXzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:55:09 -0500
Date: Tue, 10 Jan 2006 17:54:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ata errors -> read-only root partition. Hardware issue?
In-reply-to: <5ttip-Xh-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C4493A.4010305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5ttip-Xh-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:
> 
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> SCSI error : <2 0 0 0> return code = 0x8000002
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 67801511

That sounds an awful lot like a failing hard drive.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

