Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267872AbTBRPUf>; Tue, 18 Feb 2003 10:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267873AbTBRPUe>; Tue, 18 Feb 2003 10:20:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21130
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267872AbTBRPUe>; Tue, 18 Feb 2003 10:20:34 -0500
Subject: Re: sis7012 and no sound
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jake Roersma <jake@copiosus.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045536323.389.17.camel@phobos>
References: <1045536323.389.17.camel@phobos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045585942.24171.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Feb 2003 16:32:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 02:45, Jake Roersma wrote:
> I just got a new laptop and it has the sis7012 audio chipset in it.  I
> am having a problem getting the sound work with the stock 2.4.18, and
> 2.4.20 kernels.  I did some googling on it and found that having ACPI
> enabled in the kernel might help, but it didn't.  As of right now the
> kernel finds the sis7012 chip fine with the i810_audio module and gives
> the following output:
> 

Some SIS audio works, some doesn't. The only reason it works at all is that
its a bad clone of an intel part and people discovered this. We have no
SiS documentation on the 7012.

