Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTAJLFq>; Fri, 10 Jan 2003 06:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbTAJLFq>; Fri, 10 Jan 2003 06:05:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34193
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264903AbTAJLFq>; Fri, 10 Jan 2003 06:05:46 -0500
Subject: Re: Linux 2.4.21pre3-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110094504.GM25979@charite.de>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
	 <20030110094504.GM25979@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042200029.28469.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 12:00:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 09:45, Ralf Hildebrandt wrote:
> I got an oops with that kernel on two different machines:

Can you build the kernel with the patch to mm/shmem.c reverted and
see if that fixes your crash ?

