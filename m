Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291033AbSBNIGv>; Thu, 14 Feb 2002 03:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289670AbSBNIGj>; Thu, 14 Feb 2002 03:06:39 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.36]:28159 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S290983AbSBNIGa>; Thu, 14 Feb 2002 03:06:30 -0500
Message-ID: <E244E44D6AB85E40AEEF7EAABE3545FA08ABDC@enleent104.nl.eu.ericsson.se>
From: "Henk de Groot (ELN)" <Henk.de.Groot@eln.ericsson.se>
To: "'tpm@prkele.tky.hut.fi'" <tpm@prkele.tky.hut.fi>,
        "Henk de Groot (ELN)" <Henk.de.Groot@eln.ericsson.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-hams@vger.kernel.org'" <linux-hams@vger.kernel.org>,
        "'stephen@g6dzj.demon.co.uk'" <stephen@g6dzj.demon.co.uk>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'henk.de.groot@hetnet.nl'" <henk.de.groot@hetnet.nl>
Subject: RE: AX25 Patches for 2.4.17 and above - have they been included y
	 et
Date: Thu, 14 Feb 2002 09:05:58 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tomi

> From: Tomi Manninen [mailto:tpm@prkele.tky.hut.fi]
> It's in 2.4.18-pre9.

Thanks. I'm using the latest patch from Jeroen for a month now (in a 2.4.16 kernel - the 2.4.17 kernel seems to have - not HAM related - problems). It seems to work fine.

Do you know if a patch against the "protocol is buggy" messages is also planned? I think it will be long before the HAM programs will be switched to the new packet-driver and it is a bit pointless to have the logs floaded with these messages. It's better to have one "depricated" warning once when opening the socket with AF_INET or PF_INIT and SOCK_PACKET making clear what's causing it.

Kind regards,

Henk.
