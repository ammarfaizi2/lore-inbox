Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTELNxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTELNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:53:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65431
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262150AbTELNxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:53:09 -0400
Subject: Re: 2.4.20 hangs after probing CPU 0 APIC timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-smp@vger.kernel.org
In-Reply-To: <16063.39093.297546.462874@chiark.greenend.org.uk>
References: <16063.39093.297546.462874@chiark.greenend.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052744842.31246.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 14:07:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 13:51, Ian Jackson wrote:
> The machine is dual PIII; the motherboard is an Asus CUV-D.  The
> system is at a colo and I don't have access to the VGA display, but
> LILO and the kernel are set up to use a serial console and I have a
> remote power cycler too.

There were a load of problems reported with the CUV-D series boards when
they first came out. I was under the impression a bios updated fixed
things but do a search both in the Red Hat bugzilla and mailing list
stuff and hopefully the info will turn up somewhere

