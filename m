Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSKBIMb>; Sat, 2 Nov 2002 03:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSKBIMb>; Sat, 2 Nov 2002 03:12:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262862AbSKBIMa>;
	Sat, 2 Nov 2002 03:12:30 -0500
Message-ID: <3DC38A46.5060806@pobox.com>
Date: Sat, 02 Nov 2002 03:18:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
References: <3DC38939.90001@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah... quick addition.

At some point in the evolution, I will add the ability to load initramfs 
in all the ways that initrd is currently loaded now (from the 
bootloader, etc.).  Substituting a custom initramfs cpio archive in the 
kernel link will also be added at a later time.



