Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVE2VuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVE2VuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVE2VuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:50:10 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:19659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVE2VuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:50:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=tcDaDGyLJje8OXoOKuyxju9LZnwur5Q5YL4sUihMIYAa3jOdIkZrXiQD6cjJav9IqIy9DDIDtR3o+c2zY/A4V66+DR/AI99BxXh6vlqaWCTBn1YA1J75IG14xXWVQJtkMN2Obo5TqkocUzQ2AOeHRX2MTiwxxiwiVAnVRDKs46c=
Message-ID: <429A3902.8030109@gmail.com>
Date: Sun, 29 May 2005 23:49:54 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>
In-Reply-To: <20050526140058.GR1419@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sometimes when I boot the kernel is unable to get the correct geometrie
of my Samsung drives.

Can only provide this message the kernel prints:

    getblk();invalid blocksize 166869779 hardsect: 512

That's everthing I've got.

When it boot correctly I get this for the drives:

    SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sda: drive cache: write back
    SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sda: drive cache: write back
     sda: sda1 sda2 < sda5 >
    Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
    SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
    Losing some ticks... checking if CPU frequency changed.
    SCSI device sdb: drive cache: write back
    SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sdb: drive cache: write back
     sdb: sdb1 sdb2 < sdb5 sdb6 >

If you need further infos let me now.

Greets
    Michael

