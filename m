Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbQKUAfK>; Mon, 20 Nov 2000 19:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQKUAfA>; Mon, 20 Nov 2000 19:35:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:5386 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129097AbQKUAeo>;
	Mon, 20 Nov 2000 19:34:44 -0500
Date: Tue, 21 Nov 2000 01:02:43 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: USB: Wacom Graphire mouse wheel does not work anymore
To: karl.gustav@gmx.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <30913.974749254@www23.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20001121021309.F1F145962@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov, karl.gustav@gmx.net wrote:

> I used the IMPS/2 compatible mouse emulation of the wacom driver
> (/dev/input/mice).

 Don't do that. It's evil. Use the xinput driver instead.
 
> PS: Is there an OHCI compliant PCI USB controller card available? I'm
>     using an UHCI type with a VIA chip.

 Yes, Belkin makes one. Originally it was designed for a Mac but it
 should work under linux i386, too. The name seems to be "2 Port USB
 PCI-Card"

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
