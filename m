Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293039AbSBVXEB>; Fri, 22 Feb 2002 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293037AbSBVXDv>; Fri, 22 Feb 2002 18:03:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:271 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293036AbSBVXDh>;
	Fri, 22 Feb 2002 18:03:37 -0500
Message-ID: <3C76CE17.7010001@evision-ventures.com>
Date: Sat, 23 Feb 2002 00:02:47 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        =?ISO-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.10.10202221210430.2519-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> 
> Okay we are getting some place now, cause what I was reading and seeing in
> the changes registers a DRIVE to the PCI API and not a HOST.

The changes add a only a drive and driver,
becouse a pci_dev was already there and is used.
This is by the way corresposnding to the HOST host.

Can't be that you don't understand the code you claim to care
that much about?


