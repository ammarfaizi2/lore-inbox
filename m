Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJEQf3>; Sat, 5 Oct 2002 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbSJEQf3>; Sat, 5 Oct 2002 12:35:29 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:50670 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262391AbSJEQf2>; Sat, 5 Oct 2002 12:35:28 -0400
Subject: Re: IDE subsystem issues with 2.4.1[89] [REVISITED]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Costa <brblueser@uol.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005131823.676c1bcc.brblueser@uol.com.br>
References: <20021005114725.3af9c194.brblueser@uol.com.br>
	<1033833579.4103.2.camel@irongate.swansea.linux.org.uk> 
	<20021005131823.676c1bcc.brblueser@uol.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 17:49:50 +0100
Message-Id: <1033836590.4079.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 16:18, Andre Costa wrote:
> Seriously speaking: do you have confirmartion that the IDE updates on
> the -ac branch fix the cd audio ripping timeouts? Do you want me to try
> it out? <newbie>If so, can I simply apply the 2.4.20-pre8-ac3 on top of
> my vanilla 2.4.19 source code or is any other patch required?</newbie>

Depends entirely on your hardware and a lot of other things. Right now
the ide-scsi code in the 2.5/2.4-ac tree still needs some more work
The 2.4 base code ought to be working (ie 2.4.19/2.4.20-pre)

