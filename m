Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbSKOVVw>; Fri, 15 Nov 2002 16:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKOVVw>; Fri, 15 Nov 2002 16:21:52 -0500
Received: from dav74.sea2.hotmail.com ([207.68.164.209]:52232 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S266746AbSKOVVt>;
	Fri, 15 Nov 2002 16:21:49 -0500
X-Originating-IP: [216.36.75.11]
From: "Arcot Arumugam" <arcot_arumugam@hotmail.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
References: <DAV35iMCIqtQvAauNjV00005dc0@hotmail.com> <1037396151.22279.5.camel@rth.ninka.net>
Subject: Re: TCPPureAcks TCPHPAcks - Definition?
Date: Fri, 15 Nov 2002 13:41:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <DAV744vvsGOkevWWGxe00001ada@hotmail.com>
X-OriginalArrivalTime: 15 Nov 2002 21:28:40.0640 (UTC) FILETIME=[F7725C00:01C28CED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<...>
> read and unstand the
> places in the TCP stack sources where these counters are
> bumped

I will do that.

But does it hurt so much that the networking stack developers cannot provide
a comment for each field?

I know they are busy people and do not do such "trivial" things.

Thanks anyway

Arcot

----- Original Message -----
From: "David S. Miller" <davem@redhat.com>
To: "Arcot Arumugam" <arcot_arumugam@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, November 15, 2002 1:35 PM
Subject: Re: TCPPureAcks TCPHPAcks - Definition?


> On Fri, 2002-11-15 at 13:03, Arcot Arumugam wrote:
> > Does anyone know about what these fields contain? Is it documented
anywhere?
>
> They are statistics for the developers of the networking
> stack, if you can't be bothered to read and unstand the
> places in the TCP stack sources where these counters are
> bumped then congratulations these statistics can safely
> be ignored by you :-)
>
