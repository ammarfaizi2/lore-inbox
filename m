Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSESQXd>; Sun, 19 May 2002 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSESQXc>; Sun, 19 May 2002 12:23:32 -0400
Received: from [62.70.58.70] ([62.70.58.70]:8064 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314475AbSESQXb> convert rfc822-to-8bit;
	Sun, 19 May 2002 12:23:31 -0400
Message-Id: <200205191623.g4JGNNW06406@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Dave Jones <davej@suse.de>
Subject: Re: nVidia NIC/IDE/something support?
Date: Sun, 19 May 2002 18:23:23 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205191514.g4JFEsV13608@mail.pronto.tv> <20020519175838.I15417@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 May 2002 17:58, Dave Jones wrote:
> On Sun, May 19, 2002 at 05:14:54PM +0200, Roy Sigurd Karlsbakk wrote:
>  > I just bought this Asus board, A7N266-VM, with nVidia IDE, LAN and god
>  > knows chipset. Linux doesn't understand it, and I really want it... Any
>  > plans of supporting this? See below for /proc/pci output.
>
> It's an nForce chipset. To the best of my knowledge, there are no
> public specs for this beast, so your only hope is probably to bug
> nVidia.

it looks like the LAN part is an RTL8201L, but I get some EEPROM read error...

-- 
Roy Sigurd Karlsbakk

Computers are like air conditioners.
They stop working when you open Windows.
