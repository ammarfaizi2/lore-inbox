Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTANI5e>; Tue, 14 Jan 2003 03:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTANI5e>; Tue, 14 Jan 2003 03:57:34 -0500
Received: from AMarseille-201-1-3-195.abo.wanadoo.fr ([193.253.250.195]:21617
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261855AbTANI5d>; Tue, 14 Jan 2003 03:57:33 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: root@chaos.analogic.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Ross Biro <rossb@google.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030113201527.31662A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030113201527.31662A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042535166.587.36.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Jan 2003 10:06:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 02:20, Richard B. Johnson wrote:

> It is not, as you say; "obviously wrong". It is, in fact correct.
> If you think you will get, as previously stated, the current status
> by reading the status register of a device, while a posted-write
> is in-progress, the code is broken. There are warnings all over
> PCI device hardware specifications about this. 

Can you point me to such a warning in the PCI2.1 or 2.2 spec please ?

Ben.


