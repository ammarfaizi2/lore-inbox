Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSGMFqi>; Sat, 13 Jul 2002 01:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSGMFqh>; Sat, 13 Jul 2002 01:46:37 -0400
Received: from codepoet.org ([166.70.99.138]:24792 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318101AbSGMFqg>;
	Sat, 13 Jul 2002 01:46:36 -0400
Date: Fri, 12 Jul 2002 23:49:29 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joerg Schilling <schilling@fokus.gmd.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020713054928.GB19292@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joerg Schilling <schilling@fokus.gmd.de>,
	linux-kernel@vger.kernel.org
References: <200207121957.g6CJvXLs018439@burner.fokus.gmd.de> <1026508641.9915.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026508641.9915.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 12, 2002 at 10:17:21PM +0100, Alan Cox wrote:
> CD burning is a side issue to stability and reliability. 
> 
> In terms of supporting old hardware most of that is irrelevant to cd
> recording anyway, so why do you care ? What you actually need is a
> generic interface for cd packet sending.

A generic interface for cd packet sending?  Sounds useful.  So
useful someone thought of it years ago, and called it the
CDROM_SEND_PACKET ioctl.  Its been in the kernel since Aug 1999.
What'll those crazy Linux CD-ROM people think of next?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
