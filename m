Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSHFT74>; Tue, 6 Aug 2002 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSHFT74>; Tue, 6 Aug 2002 15:59:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315459AbSHFT7z>;
	Tue, 6 Aug 2002 15:59:55 -0400
Date: Tue, 6 Aug 2002 13:01:14 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Diego Calleja <diegocg@teleline.es>, <linux-kernel@vger.kernel.org>
Subject: Re: pppd[32497]: Unsupported protocol 'CallBack Control Protocol
 (CBCP)' (0xc029) received
In-Reply-To: <Pine.LNX.3.95.1020806152633.25149B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0208061257180.10089-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Richard B. Johnson wrote:

| On Tue, 6 Aug 2002, Diego Calleja wrote:
|
| > In different kernels I've seen this message:
| >
| > Aug  6 19:10:01 localhost pppd[32497]: Unsupported protocol 'CallBack
| > Control Protocol (CBCP)' (0xc029) received
| >
| > Is pppd who has to handle this protocol, or it's a "ToDo" in ppp in the
| > kernel? In the last case, will it be implemented?
| >
| > and, what's the hell is the "Callback Protocol?"
|
| You are connected to a M$ 'server' and it's trying to interrogate
| your machine with 'Magic Lantern'. I don't think you want it
| implemented. From what I hear, it's what the US Government decided
| that M$ must put into everything so that any 'Duly authorized....'
| can peer into your computer.
|
| Check it out. Scary...

I've never heard this explanation, but who knows??

I've heard of callback relating to RAS as a method of preventing
just anyone calling into a particlar RAS server.
Using callbacks, the server hangs up and immediately calls the
originator back to a valid, known telephone number.
Also allows the server to be billed for it instead of the caller.

At MS web site:
<quote>
Callback Negotiation with the Callback Control Protocol
The Callback Control Protocol (CBCP) is documented in
ftp://ftp.microsoft.com/developr/rfc/cbcp.txt .
CBCP negotiates the use of callback where the remote access server,
after authenticating the remote access client, terminates the physical
connection, waits a specified amount of time, and then calls the remote
access client back at either a static or dynamically configured phone
number. Common CBCP options include the phone number being used by the
remote access server to call the remote access client back.
</quote>

-- 
~Randy

