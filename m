Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284730AbRLZSup>; Wed, 26 Dec 2001 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLZSug>; Wed, 26 Dec 2001 13:50:36 -0500
Received: from mail.zabbadoz.net ([195.2.176.194]:31504 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S284730AbRLZSuU>; Wed, 26 Dec 2001 13:50:20 -0500
Date: Wed, 26 Dec 2001 19:50:13 +0100 (CET)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: <toxischerabflussreiniger@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: writing device drivers for commercial hardware
In-Reply-To: <3C2A1D7E.25900.13D1DF@localhost>
Message-ID: <Pine.BSF.4.30.0112261942310.727-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001 toxischerabflussreiniger@gmx.net wrote:

> As I'm new to linux kernel development I wonder how to write a
> device driver, say for a card reader, if you don't have some
> documentation about it.
> How do you manage that? Searching for it in the web? I really don't
> know ... there's a small book with my card reader but you won't find
> a single line about technical stuff in it.
> It's a (pretty simple and cheap) card reader connected to serial port.

Hi,

did something similar before christmas. Had a small win installation in
a vmware, slsnif running on the linux host and connected vmware on a
ttyp slsnif gave me. easy.

BTW what card reader is it ? There are already enough _user space_
implementations for serial smartcard readers. This is where this
normally belongs to.
Check http://www.linuxnet.com/ p.ex.

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

