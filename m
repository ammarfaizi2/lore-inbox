Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268860AbTB0A1Q>; Wed, 26 Feb 2003 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268866AbTB0A1Q>; Wed, 26 Feb 2003 19:27:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268860AbTB0A1P>;
	Wed, 26 Feb 2003 19:27:15 -0500
Subject: Re: 2.5 porting items
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linstab@osdl.org
In-Reply-To: <20030226220936.GN7685@fs.tum.de>
References: <1046221420.20288.17.camel@cherrytest.pdx.osdl.net>
	 <20030226220936.GN7685@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1046306405.29529.15.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 26 Feb 2003 16:40:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good idea.  I have added the #error items and they will show up in the
build tonight.  Again, the link is:

http://www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt

John

On Wed, 2003-02-26 at 14:09, Adrian Bunk wrote:
> Please add the following #error's to your list:
> 
> net/defxx.c:#error Please convert me to Documentation/DMA-mapping.txt
> net/rcpci45.c:#error Please convert me to Documentation/DMA-mapping.txt
> scsi/pci2220i.c:#error Convert me to understand page+offset based scatterlists
> scsi/scsiiom.c:#error Please convert me to Documentation/DMA-mapping.txt
> scsi/ini9100u.c:#error Please convert me to Documentation/DMA-mapping.txt
> scsi/AM53C974.c:#error Please convert me to Documentation/DMA-mapping.txt
> scsi/dpt_i2o.c:#error Please convert me to Documentation/DMA-mapping.txt
> 
> 
> cu
> Adrian

