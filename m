Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTAKRil>; Sat, 11 Jan 2003 12:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTAKRil>; Sat, 11 Jan 2003 12:38:41 -0500
Received: from inova101.correio.tnext.com.br ([200.222.67.101]:54973 "HELO
	leia-out.correio.tnext.com.br") by vger.kernel.org with SMTP
	id <S267106AbTAKRij>; Sat, 11 Jan 2003 12:38:39 -0500
Message-ID: <3E205888.5000500@veloxmail.com.br>
Date: Sat, 11 Jan 2003 15:46:48 -0200
From: Marcelo Pacheco <macpacheco@veloxmail.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair Strachan <alistair@devzero.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.56] Oops using pppd.
References: <200301111736.57416.alistair@devzero.co.uk>
In-Reply-To: <200301111736.57416.alistair@devzero.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan wrote:

>Find attached a decoded kernel oops which I have only _noticed_ since 2.5.56. 
>This is difficult to reproduce, but seems to happen when pppd completes 
>authentication. The connection is dropped immediately.
>  
>
As a counter example, I'm running pppoe with pppd 2.4.2b1 and the 
rp-pppoe.so plugin with pap authentication under 2.5.56 right now.
Granted this doesn't use a physical serial port, but it does exercise de 
ppp driver and pap authentication.

