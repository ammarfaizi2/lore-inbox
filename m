Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTAHNCz>; Wed, 8 Jan 2003 08:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAHNCz>; Wed, 8 Jan 2003 08:02:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54921
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267393AbTAHNCS>; Wed, 8 Jan 2003 08:02:18 -0500
Subject: Re: small fix for nforce ide chipset driver in 2.5.54
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Curbo <phoenix@sandwich.net>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030108075539.GA4128@carthage>
References: <20030108075539.GA4128@carthage>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042034033.24099.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 13:53:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 07:55, James Curbo wrote:
> so I added a #define for PCI_DEVICE_ID_NVIDIA_NFORCE_IDE as 0x0065. It
> compiled fine and I am in fact running that kernel now. I would have
> just sent a patch but I am new to kernel hacking, this is just a one
> liner and I'm sure you know where it goes better than I do.

Someone deleted it about 2.5.50, and though I sent in the fix twice Linus
still hasn't applied it 8(

