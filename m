Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129907AbRBSQwf>; Mon, 19 Feb 2001 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRBSQwZ>; Mon, 19 Feb 2001 11:52:25 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:5091 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129907AbRBSQwP>; Mon, 19 Feb 2001 11:52:15 -0500
Message-ID: <3A914E57.9990EB7C@sympatico.ca>
Date: Mon, 19 Feb 2001 11:48:23 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: peterw@dascom.com.au, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel executation from ROM
In-Reply-To: <XFMail.20010219124909.peterw@dascom.com.au> <01e701c09a2a$21e789a0$bba6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:

> Dear Sirs,
>
> Thanks for your help,
>
> I see . The biggest negative point of running kernel from ROM is that ROM
> speed is slow :(

Also, the PCI specification forbids executing code from ROMs over the PCI bus.
The system BIOS in a PC is not on the PCI bus, bus, but everything else is.

