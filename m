Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTD3NCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTD3NCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:02:48 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:41095 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262164AbTD3NCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:02:47 -0400
Date: Wed, 30 Apr 2003 15:14:21 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Bootable CD idea
Message-ID: <20030430131421.GB2815@louise.pinerecords.com>
References: <Pine.LNX.4.53.0304300811300.12971@chaos> <200304301241.h3UCfDPp000309@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304301241.h3UCfDPp000309@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> I didn't think we'd need to modify anything - the BIOS lets us choose
> the floppy image we want, so each image only needs to contain a
> bootloader[1], and a kernel.

Why not use isolinux[1] to boot however many images you feel like booting?

-- 
Tomas Szepe <szepe@pinerecords.com>

[1] http://syslinux.zytor.com/iso.php
