Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131156AbRA1PTa>; Sun, 28 Jan 2001 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135420AbRA1PTU>; Sun, 28 Jan 2001 10:19:20 -0500
Received: from inpbox.inp.nsk.su ([193.124.167.24]:63911 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S131156AbRA1PTI>; Sun, 28 Jan 2001 10:19:08 -0500
Date: Sun, 28 Jan 2001 21:10:02 +0600
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
To: Stefani Seibold <stefani@seibold.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk and panic messages, third try
In-Reply-To: <01012815533500.01191@deepthought.seibold.net>
Message-ID: <Pine.SGI.4.10.10101282105340.644749-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Stefani Seibold wrote:

> this is now the third try to release my patch for disabling all kernel 
> messages. It is usefull on deep embedded systems with no human interactions 

> --- linux/arch/s390/config.in	Thu Nov 16 21:51:28 2000
> +++ linux.noprintk/arch/s390/config.in	Sun Jan 28 10:56:15 2001

> +bool 'Disable kernel messages' CONFIG_NOPRINTK


S/390 on embedded systems? :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
