Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTDVXBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbTDVXBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:01:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7905
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263905AbTDVXBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:01:42 -0400
Subject: Re: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: eric.valette@free.fr
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EA59949.6040104@free.fr>
References: <3EA4FF4C.2030702@free.fr>
	 <200304221036.19274.m.c.p@wolk-project.de>
	 <1051020692.14881.12.camel@dhcp22.swansea.linux.org.uk>
	 <3EA59949.6040104@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051049747.15769.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 23:15:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-22 at 20:34, Eric Valette wrote:
> On the other hand, probably mainy/every server with  dual scsi cards 
> (one for 160 Mbps and other for slow devices as tape, cdrom, ...) will 
> probably not boot with actual good blessed code :-)
> 
> Never mind :
> 	1) I have warned and done my debugging duty by sending a kdbg backtrace,
> 	2) I suggested a possible fix,
> 	3) I have a solution for myself,

Indeed, and its on the list to try and work through. The size of the changes from
.0 to .6 make it non trivial though

