Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSHPIBQ>; Fri, 16 Aug 2002 04:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSHPIBQ>; Fri, 16 Aug 2002 04:01:16 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:53516 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S318305AbSHPIBQ>;
	Fri, 16 Aug 2002 04:01:16 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: wild card MAC address
Date: Fri, 16 Aug 2002 10:07:11 +0200
Organization: Cistron
Message-ID: <ajibn7$uvc$1@ncc1701.cistron.net>
References: <3D5C5498.867E0359@efi.com>
X-Trace: ncc1701.cistron.net 1029485095 31724 62.177.159.162 (16 Aug 2002 08:04:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kallol Biswas" <kallol@efi.com> wrote in message
news:cistron.3D5C5498.867E0359@efi.com...
> I am not sure if this message is posted to the right mailing list.
>
> Is there any way to specify wildcard mac adress in the bootptab file?
> It looks like no, the bootpd applies hash algorithm on the hardware
> address
> of the incoming bootp client request and sends a reply.
>

Try 'man bootptab', look at the section describing .default:

Rob




