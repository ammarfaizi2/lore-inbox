Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTD3MeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTD3MeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:34:21 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:21633 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S262151AbTD3MeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:34:20 -0400
Date: Wed, 30 Apr 2003 14:47:33 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: John Bradford <john@grabjohn.com>
cc: root@chaos.analogic.com, <linux-kernel@vger.kernel.org>
Subject: Re: Bootable CD idea
In-Reply-To: <200304301241.h3UCfDPp000309@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0304301446450.2375-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, John Bradford wrote:
> [1] I originally thought that the 2.4 kernel's in-built floppy
> bootloader used BIOS calls to access the disk, and that a 2.4 kernel
> image as the El-Torito boot image would work, as the kernel would be
> accessing the emulated disk, but it didn't seem to when I tried it
> just now - it failed with an error saying something along the lines of
> it had run out of data to decompress.

when you did "make bzImage", are you sure you didn't get the message about 
the kernel being too big for floppy booting?

Regards
Tigran

