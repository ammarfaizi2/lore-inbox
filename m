Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279250AbRKIJTz>; Fri, 9 Nov 2001 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279326AbRKIJTp>; Fri, 9 Nov 2001 04:19:45 -0500
Received: from ns.sysgo.de ([213.68.67.98]:16111 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S279250AbRKIJT1>;
	Fri, 9 Nov 2001 04:19:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rkaiser@sysgo.de
Organization: Sysgo RTS GmbH
To: pallaire@gameloft.com
Date: Fri, 9 Nov 2001 10:19:36 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01110910184800.01293@rob>
Content-Transfer-Encoding: 7BIT
Subject: Re: Kernel booting on serial console ... crawling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to boot my kernel using the serial console, using the
> console=ttyS0,115200 (it does the same thing with 9600) ... it work great
> until :
> 
> Freeing unused kernel memory: 36k freed
> serial console detected.  Disabling virtual terminals.
> console=/dev/ttyS0
> 
> At this point the output of the serial line slow down dramaticly ... almost
> to a halt ... I get 1 line every 30 seconds !!!
> 

Is this an AMD Elan's built-in serial port, perchance ?

Rob
 
----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
